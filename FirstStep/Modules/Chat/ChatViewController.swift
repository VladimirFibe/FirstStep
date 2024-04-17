import UIKit
import MessageKit
import InputBarAccessoryView

final class ChatViewController: MessagesViewController {
    let recent: Recent
    private let refreshControl = UIRefreshControl()
    private let micButton = InputBarButtonItem()
    private var longPressGesture: UILongPressGestureRecognizer!
    var mkMessages: [MKMessage] = []
    let currentPerson = MKSender(senderId: Person.currentId, displayName: Person.currentName)
    init(recent: Recent) {
        self.recent = recent
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let message = CoreDataManager.shared.createMessage(text: "Yes!") else { return }
        FirebaseClient.shared.sendMessage(message, recent: recent)
//        FirebaseClient.shared.clearRecentCounter(recent)

        configureGestureRecognizer()
        configureMessageCollectionView()
        configureMessageInputBar()
    }
}
// MARK: - Configurations
extension ChatViewController {
    private func configureMessageCollectionView() {
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messageCellDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messageCellDelegate = self
        messagesCollectionView.refreshControl = refreshControl

        scrollsToLastItemOnKeyboardBeginsEditing = true
        maintainPositionOnInputBarHeightChanged = true
    }

    private func configureMessageInputBar() {
        messageInputBar.delegate = self

        let attachButton = InputBarButtonItem()
        let attachConfig = UIImage.SymbolConfiguration(pointSize: 30)
        attachButton.image = UIImage(systemName: "plus", withConfiguration: attachConfig)
        attachButton.setSize(CGSize(width: 30, height: 30), animated: false)
        attachButton.onTouchUpInside { item in self.actionAttachMessage() }

        let micConfig = UIImage.SymbolConfiguration(pointSize: 30)
        micButton.image = UIImage(systemName: "mic.fill", withConfiguration: micConfig)
        micButton.setSize(CGSize(width: 30, height: 30), animated: false)
        micButton.addGestureRecognizer(longPressGesture)

        messageInputBar.setStackViewItems([attachButton], forStack: .left, animated: false)
        messageInputBar.setLeftStackViewWidthConstant(to: 36, animated: false)
        messageInputBar.inputTextView.isImagePasteEnabled = false
        messageInputBar.backgroundView.backgroundColor = .systemBackground
        messageInputBar.inputTextView.backgroundColor = .systemBackground
    }

    private func configureGestureRecognizer() {
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(recordAudio))
        longPressGesture.minimumPressDuration = 0.5
        longPressGesture.delaysTouchesBegan = true
    }
}
// MARK: - Actions
extension ChatViewController {
    private func actionAttachMessage() {

    }

    @objc private func recordAudio() {

    }
}
