import Combine
import UIKit
import Foundation

class ImageViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()

    func loadImage(imageUrl: String) {
        CacheManager.cacheImage(imageUrl: imageUrl)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { image in
                self.image = image
            })
            .store(in: &cancellables)
    }
}
