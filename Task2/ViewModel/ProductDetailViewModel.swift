import Foundation
import CoreData
import Combine

class ProductDetailViewModel: ObservableObject {
    @Published var selectedProductDetail: ProductDetailModel?
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
       
    
    // Ürün detaylarını fetch etmek
    func fetchProductDetail(for id: Int) {
        APIClient.shared.fetchProductDetail(id: id)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    // Hata durumunda hata mesajını güncelliyoruz
                    DispatchQueue.main.async {
                        self.errorMessage = error.localizedDescription
                    }
                case .finished:
                    break
                }
            }, receiveValue: { detail in
                // Başarı durumunda ürün detaylarını güncelliyoruz
                DispatchQueue.main.async {
                    self.selectedProductDetail = detail
                    //burda urun detayini coreData uzerinden kayit edebiliriz
                }
            })
            .store(in: &cancellables) // Combine aboneliğini tutuyoruz
    }
    
}
