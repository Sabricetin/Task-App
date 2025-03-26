import Foundation

struct ProductDetailModel: Decodable {
      let id: Int
      let title, description, category: String
      let price, discountPercentage, rating: Double
      let stock: Int
      let tags: [String]
      let brand, sku: String
      let weight: Int
      let dimensions: Dimensions
      let warrantyInformation, shippingInformation, availabilityStatus: String
      let reviews: [ReviewModel]
      let returnPolicy: String
      let minimumOrderQuantity: Int
      let meta: Meta
      let images: [String]
      let thumbnail: String
}
