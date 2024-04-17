import Foundation
import CoreData

@objc(Message)
public class Message: NSManagedObject {

}

extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }

    @NSManaged public var id: String?
    @NSManaged public var chatRoomId: String?
    @NSManaged public var date: Date?
    @NSManaged public var name: String?
    @NSManaged public var uid: String?
    @NSManaged public var initials: String?
    @NSManaged public var read: Date?
    @NSManaged public var type: String?
    @NSManaged public var status: String?
    @NSManaged public var text: String?
    @NSManaged public var audio: String?
    @NSManaged public var video: String?
    @NSManaged public var photo: String?
//    @NSManaged public var latitude: Float?
//    @NSManaged public var longitude: Float?
//    @NSManaged public var duration: String?
}

extension Message : Identifiable {

}
