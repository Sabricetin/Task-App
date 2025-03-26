import Foundation
import UIKit
import Combine

class CacheManager {

    static func cacheImage(imageUrl: String) -> AnyPublisher<UIImage?, APIError> {
        guard let url = URL(string: imageUrl) else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()  // Geçersiz URL hatası
        }

        let request = URLRequest(url: url)
        
        // Eğer önbellekten çekilen veri varsa, bunu alıyoruz
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            let image = UIImage(data: cachedResponse.data)
            return Just(image)
                .setFailureType(to: APIError.self)
                .eraseToAnyPublisher()
        }

        // Cache'te yoksa, ağ üzerinden çekiyoruz
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { data, response in
                // Gelen veriyi cache'e kaydediyoruz
                let cachedData = CachedURLResponse(response: response, data: data)
                URLCache.shared.storeCachedResponse(cachedData, for: request)

                // Veriden resmi işliyoruz
                return UIImage(data: data)
            }
            .mapError { error in
                return APIError.networkError // Ağ hatası
            }
            .receive(on: DispatchQueue.main) // UI işlemleri ana iş parçacığında yapılır
            .eraseToAnyPublisher()
    }
}
