import Foundation

struct APIPaths {
    static let baseURL = "https://dummyjson.com/"
    
    // Ürünler için path
    static let products = "\(baseURL)products"
    
    // Ürün detayları için path
    static func productDetail(id: Int) -> String {
        return "\(baseURL)products/\(id)"
    }
    
    // Diğer endpointler için eklemeler
}
