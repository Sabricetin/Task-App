import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()

    // Core Data stack'i
    private(set) lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ProductsContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unresolved error \(error.localizedDescription)")
            }
        }
        return container
    }()

    // Context: Veritabanı ile etkileşim
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // Değişiklikleri kaydetme
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
