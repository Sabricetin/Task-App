import Foundation
import Combine

class APIClient {
    
    static let shared = APIClient()
    private init() {}

    // Combine ile ürünleri çekme
    func fetchProducts(page: Int) -> AnyPublisher<[ProductModel], APIError> {
        let urlString = "\(APIPaths.products)?page=\(page)" //varsayiyorum ki burda pagination yapiyorum

        guard let url = URL(string: urlString) else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()  // Geçersiz URL hatası
        }

        let request = URLRequest(url: url)
                // Eğer önbellekten çekilen veri varsa, bu veriyi kullanıyoruz
                if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
                    
                    let products = parseJSON(data: cachedResponse.data, modelType: ProductData.self)
                    return Just(products?.products ?? [])
                        .setFailureType(to: APIError.self)
                        .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { data, response in
                // Veriyi çözümle
                let productData = parseJSON(data: data, modelType: ProductData.self)
                return productData!.products
                
            }
            .mapError { _ in APIError.networkError } // Ağ hatası
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchProductDetail(id: Int) -> AnyPublisher<ProductDetailModel, APIError> {
        guard let url = URL(string: APIPaths.productDetail(id: id)) else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()  // Geçersiz URL hatası
        }
        
        let request = URLRequest(url: url)
        
        // Eğer önbellekten çekilen veri varsa, bu veriyi kullanıyoruz
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            // Önbellekten alınan veriyi çözümle
            if let productDetail = parseJSON(data: cachedResponse.data, modelType: ProductDetailModel.self) {
                return Just(productDetail)
                    .setFailureType(to: APIError.self)
                    .eraseToAnyPublisher()
            } else {
                // Önbellekten alınan veri geçersizse, hata dönüyoruz
                return Fail(error: APIError.decodingError)
                    .eraseToAnyPublisher()
            }
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response -> ProductDetailModel in
                // Veriyi çözümle
                if let productDetail = parseJSON(data: data, modelType: ProductDetailModel.self) {
                    return productDetail
                } else {
                    throw APIError.decodingError
                }
            }
            .mapError { error in
                // Hata durumu kontrolü
                if let urlError = error as? URLError {
                    return APIError.networkError  // Ağ hatası
                }
                return APIError.decodingError  // Çözümleme hatası
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }



}
