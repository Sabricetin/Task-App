import SwiftUI
import Combine

class ProductViewModel: ObservableObject {
    @Published var products: [ProductModel] = []
    @Published var errorMessage: String?
    @Published var isLoading = false

    
    private var cancellables = Set<AnyCancellable>()
    private let networkMonitor = NetworkMonitor() // Network monitor
    private let persistenceController = PersistenceController.shared

    
    private var currentPage = 1

    // Ürünleri fetch etmek
      func fetchProducts() {
          // İlk sayfayı çekiyoruz
          fetchProducts(page: currentPage)
      }

      func fetchNextPage() {
          // Sayfa numarasını artırarak yeni verileri çekiyoruz
          currentPage += 1
          fetchProducts(page: currentPage)
      }
    
    // Ürünleri fetch etmek
    func fetchProducts(page: Int) {
      
        // APIClient.shared.fetchProducts artık Combine kullanarak dönecek
        APIClient.shared.fetchProducts(page: page)
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
            }, receiveValue: { products in
                // Başarı durumunda ürünleri güncelliyoruz
                DispatchQueue.main.async {
                        self.products.append(contentsOf: products)
                        self.isLoading = false
                    }
            })
            .store(in: &cancellables) // Combine aboneliğini tutuyoruz
    }
    
    
    // Core Data'dan ürünleri çekme
      private func fetchProductsFromCoreData() {
          if let coreDataProducts = persistenceController.fetchProducts() {
              DispatchQueue.main.async {
                  self.products = coreDataProducts.map { product in
                      ProductModel(
                          id: Int(product.id),
                          title: product.title ?? "bilinmiyor",
                          category: product.category ?? "bilinmiyor",
                          price: product.price,
                          thumbnail: product.thumbnail ?? "bilinmiyor"
                      )
                  }
                  self.isLoading = false
              }
          } else {
              DispatchQueue.main.async {
                  self.errorMessage = "İnternet bağlantısı yok ve lokal veriler de mevcut değil."
                  self.isLoading = false
              }
          }
      }
      
      // Verileri Core Data'ya kaydetme
      private func saveProductsToCoreData(_ products: [ProductModel]) {
          for product in products {
              persistenceController.addProduct(
                  id: Int16(product.id),
                  title: product.title,
                  price: product.price,
                  thumbnail: product.thumbnail,
                  category: product.category
              )
          }
      }
    
}
