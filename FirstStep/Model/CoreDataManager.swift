import Foundation
import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}

    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FirstStep")
        container.loadPersistentStores { store, error in
            print("DEBUG: persistent")
            if let error {
                fatalError("Loading of store failed \(error.localizedDescription)")
            } else {
                print("DEBUG: ", store.url?.absoluteString ?? "")
            }
        }
        return container
    }()

    @discardableResult
    func createMessage(_ text: String) -> Message? {
        let context = persistentContainer.viewContext
        let message = Message(context: context)
        message.text = text
        do {
            try context.save()
            return message
        } catch {
            print("Failed to create: \(error)")
        }
        return nil
    }
}
