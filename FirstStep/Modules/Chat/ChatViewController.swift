import UIKit
import MessageKit

final class ChatViewController: MessagesViewController {
    let recent: Recent

    init(recent: Recent) {
        self.recent = recent
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
