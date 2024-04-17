import Foundation
import MessageKit
import CoreLocation

class MKMessage: NSObject, MessageType {
    var sender: MessageKit.SenderType { mkSender}
    var mkSender: MKSender
    var messageId: String
    var sentDate: Date
    var kind: MessageKit.MessageKind
    var initials: String
    var incoming: Bool

    init(message: Message) {
        messageId = message.id ?? ""
        mkSender = MKSender(senderId: message.uid ?? "", displayName: message.name ?? "")
        sentDate = message.date ?? Date()
        kind = .text(message.text ?? "Hi!")
        initials = message.initials ?? "I"
        incoming = Person.currentId != mkSender.senderId
    }
}
