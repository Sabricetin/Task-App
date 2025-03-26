import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case decodingError
    case networkError
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Geçersiz URL."
        case .decodingError:
            return "Veri çözümleme hatası."
        case .networkError:
            return "Ağ bağlantısı hatası."
        case .unknown:
            return "Bilinmeyen bir hata oluştu."
        }
    }
}
