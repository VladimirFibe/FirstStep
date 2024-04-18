import UIKit
import CoreData

struct CoreDataManager {

    static let shared = CoreDataManager()
    private init() {}

    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FirstStep")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Loading of store failed \(error)")
            } else {
                print(storeDescription.url?.absoluteString ?? "")
            }
        }
        return container
    }()

    @discardableResult
    func createMessage(text: String) -> Message? {
        let context = persistentContainer.viewContext
        let message = Message(context: context)

        message.text = text

        do {
            try context.save()
            return message
        } catch let error {
            print("Failed to create: \(error)")
        }

        return nil
    }

    func fetchMessages() -> [Message]? {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<Message>(entityName: "Message")

        do {
            let messages = try context.fetch(fetchRequest)
            return messages
        } catch let error {
            print("Failed to fetch companies: \(error)")
        }

        return nil
    }

    func fetchMessage(withName text: String) -> Message? {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<Message>(entityName: "Message")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "text == %@", text)

        do {
            let messages = try context.fetch(fetchRequest)
            return messages.first
        } catch let error {
            print("Failed to fetch: \(error)")
        }

        return nil
    }

    func updateMessage(message: Message) {
        let context = persistentContainer.viewContext
        do {
            try context.save()
        } catch let error {
            print("Failed to update: \(error)")
        }
    }

    func deleteMessage(message: Message) {
        let context = persistentContainer.viewContext
        context.delete(message)
        do {
            try context.save()
        } catch let error {
            print("Failed to delete: \(error)")
        }
    }

    func sendMessage(
        recent: Recent,
        text: String?,
        photo: UIImage?,
        videoUrl: URL?,
        audio: String?,
        audioDuration: Float = 0.0,
        location: String?
    ) {
        guard let currentPerson = FirebaseClient.shared.person else { return }
        let context = persistentContainer.viewContext
        let message = Message(context: context)
        message.id = UUID().uuidString
        message.chatRoomId = recent.chatRoomId
        message.uid = Person.currentId
        message.name = currentPerson.username
        message.initials = "?"
        message.date = Date()
        message.status = "Sent"
        if let text {
            message.text = text
            message.type = "text"
        }
        do {
            try context.save()
        } catch let error {
            print("Failed to create: \(error)")
        }
    }
}
