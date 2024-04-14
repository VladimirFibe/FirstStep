import Foundation
import CoreData

@objc(Message)
public class Message: NSManagedObject {

}

extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }
    @NSManaged public var text: String?
}

extension Message : Identifiable {

}
