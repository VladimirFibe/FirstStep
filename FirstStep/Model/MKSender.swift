import Foundation
import MessageKit

struct MKSender: MessageKit.SenderType, Equatable {
    var senderId: String
    var displayName: String
}
