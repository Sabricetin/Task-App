import Foundation

struct ProductData: Decodable {
    var products: [ProductModel]
    var total: Int
    var skip: Int
    var limit: Int
}

struct ProductModel: Identifiable, Decodable {
    var id: Int
    var title: String
    var description: String?
    var category: String
    var price: Double
    var discountPercentage: Double?
    var rating: Double?
    var stock: Int?
    var tags: [String]?
    var brand: String?
    var sku: String?
    var weight: Int?
    var dimensions: Dimensions?
    var warrantyInformation: String?
    var shippingInformation: String?
    var availabilityStatus: String?
    var reviews: [ReviewModel]?
    var returnPolicy: String?
    var minimumOrderQuantity: Int?
    var meta: Meta?
    var images: [String]?
    var thumbnail: String
}

struct Dimensions: Decodable {
    var width: Double
    var height: Double
    var depth: Double
}

struct Meta: Decodable {
    var createdAt: String
    var updatedAt: String
    var barcode: String
    var qrCode: String
}
