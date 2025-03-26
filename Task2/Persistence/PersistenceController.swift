import CoreData

class PersistenceController {
    
    static let shared = PersistenceController()
    
    // Core Data Stack'ten gelen persistent container'ı kullanıyoruz
    let coreDataStack = CoreDataStack.shared
    
    private init() {}

    // Veritabanı kaydını yapacak metod
    func saveContext() {
        coreDataStack.saveContext() // CoreDataStack'teki saveContext metodunu çağırıyoruz
    }
    
    // **1. Product CRUD İşlemleri**
    
    // Ürünleri çekme
    func fetchProducts() -> [Product]? {
        let context = coreDataStack.context
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        
        do {
            let products = try context.fetch(fetchRequest)
            return products
        } catch {
            print("Error fetching products: \(error)")
            return nil
        }
    }

    // Yeni ürün ekleme
    func addProduct(id: Int16, title: String, price: Double, thumbnail: String, category: String) {
        let context = coreDataStack.context
        let product = Product(context: context)
        
        product.id = id
        product.title = title
        product.price = price
        product.thumbnail = thumbnail
        product.category = category
        
        saveContext() // Değişiklikleri kaydediyoruz
    }

    // Ürün silme
    func deleteProduct(product: Product) {
        let context = coreDataStack.context
        context.delete(product)
        saveContext() // Değişiklikleri kaydediyoruz
    }

    
    // **2. ProductDetail CRUD İşlemleri**
    
    // ProductDetail ekleme
    func addProductDetail(id: Int16, description: String, rating: Double, returnPolicy: String, minimumOrderQuantity: Int16, images: [String], product: Product) {
        let context = coreDataStack.context
        let productDetail = ProductDetail(context: context)
        
        productDetail.id = id
        productDetail.productDescription = description
        productDetail.rating = rating
        productDetail.returnPolicy = returnPolicy
        productDetail.minimumOrderQuantity = minimumOrderQuantity
        productDetail.images = images as NSArray
        productDetail.product = product
        //diger alanlari da ekleyecegiz buraya
        
        saveContext() // Değişiklikleri kaydediyoruz
    }

    // ProductDetail silme
    func deleteProductDetail(productDetail: ProductDetail) {
        let context = coreDataStack.context
        context.delete(productDetail)
        saveContext() // Değişiklikleri kaydediyoruz
    }

    
    // **3. Review CRUD İşlemleri**
    
    // Review ekleme
    func addReview(reviewerName: String, comment: String, rating: Double, productDetail: ProductDetail) {
        let context = coreDataStack.context
        let review = Review(context: context)
        
        review.reviewerName = reviewerName
        review.comment = comment
        review.rating = rating
        review.productDetail = productDetail
        
        saveContext() // Değişiklikleri kaydediyoruz
    }

    // Review silme
    func deleteReview(review: Review) {
        let context = coreDataStack.context
        context.delete(review)
        saveContext() // Değişiklikleri kaydediyoruz
    }
        
    // ProductDetail ve Review bilgilerini çekme
    func fetchProductDetail(for productId: Int16) -> ProductDetail? {
        let context = coreDataStack.context
        let fetchRequest: NSFetchRequest<ProductDetail> = ProductDetail.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", productId)
        
        do {
            let productDetails = try context.fetch(fetchRequest)
            return productDetails.first
        } catch {
            print("Error fetching product detail: \(error)")
            return nil
        }
    }

    func fetchReviews(for productDetail: ProductDetail) -> [Review]? {
        let context = coreDataStack.context
        let fetchRequest: NSFetchRequest<Review> = Review.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "productDetail == %@", productDetail)
        
        do {
            let reviews = try context.fetch(fetchRequest)
            return reviews
        } catch {
            print("Error fetching reviews: \(error)")
            return nil
        }
    }
}
