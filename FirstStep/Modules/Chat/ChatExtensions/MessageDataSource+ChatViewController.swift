import MessageKit
import Foundation

extension ChatViewController: MessagesDataSource {
    var currentSender: any MessageKit.SenderType {
        currentPerson
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> any MessageKit.MessageType {
        mkMessages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        mkMessages.count
    }
    
    
}
