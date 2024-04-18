import Firebase
import FirebaseFirestore

struct FireMessage: Codable {
    var chatRoomId: String?
    var date: Date?
    var id: String?
    var initials: String?
    var name: String?
    var read: Date?
    var status: String?
    var text: String
    var type: String?
    var uid: String?

    init(_ message: Message) {
        chatRoomId = message.chatRoomId
        date = message.date
        id = message.id
        initials = message.initials
        name = message.name
        read = message.read
        status = message.status
        text = message.text ?? ""
        type = message.type
        uid = message.uid
    }
}

final class FirebaseClient {
    enum FCollectionReference: String {
        case persons
        case messages
        case channels
    }
    let recents = "recents"
    static let shared = FirebaseClient()
    var person: Person? = nil
    private init() {}

    func createPerson(withEmail email: String, uid: String) throws {
        let person = Person(username: email, email: email)
        try reference(.persons).document(uid).setData(from: person)
    }

    func reference(_ collectionReference: FCollectionReference) -> CollectionReference {
        Firestore.firestore().collection(collectionReference.rawValue)
    }

    func clearRecentCounter(_ recent: Recent) {
        guard let currentId = person?.id else { return }
        reference(.messages)
            .document(currentId)
            .collection(recents)
            .document(recent.chatRoomId)
            .updateData(["unreadCounter": 0, "isHidden": false])
    }

    func deleteRecent(_ recent: Recent) {
        guard let currentId = person?.id else { return }
        reference(.messages)
            .document(currentId)
            .collection(recents)
            .document(recent.chatRoomId)
            .updateData(["isHidden": true])
    }

    func saveRecent(firstId: String, secondId: String, data: [String: Any]) {
        reference(.messages)
            .document(firstId)
            .collection(recents)
            .document(secondId)
            .setData(data)
    }

    func sendMessage(_ local: Message, recent: Recent) {
        let message = FireMessage(local)
        guard let currentId = person?.id else { return }
        do {
            try reference(.messages)
                .document(currentId)
                .collection(recent.chatRoomId)
                .document()
                .setData(from: message)
            try reference(.messages)
                .document(recent.chatRoomId)
                .collection(currentId)
                .document()
                .setData(from: message)
        } catch {}

        var data: [String: Any] = [
            "text":             message.text,
            "username":         recent.username,
            "date":             Date(),
            "avatarLink":       recent.avatarLink,
            "isHidden":         false,
            "unreadCounter":    0
        ]

        saveRecent(firstId: currentId, secondId: recent.chatRoomId, data: data)

        data["name"] = person?.username ?? ""
        data["avatarLink"] = person?.avatarLink ?? ""
        reference(.messages)
            .document(recent.chatRoomId)
            .collection(recents)
            .document(currentId)
            .getDocument { snapshot, error in
                if let snapshot,
                   let old = snapshot.data(),
                   let unreadCounter = old["unreadCounter"] as? Int {
                    data["unreadCounter"] = unreadCounter + 1
                } else {
                    data["unreadCounter"] = 1
                }
                self.saveRecent(
                    firstId: recent.chatRoomId,
                    secondId: currentId,
                    data: data
                )
            }
    }

    func downloadRecentChatsFromFireStore(completion: @escaping ([Recent]) -> Void) {
        guard let currentId = person?.id else { return }
        reference(.messages)
            .document(currentId)
            .collection(recents)
            .whereField("isHidden", isEqualTo: false)
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else { return }
                let recents = documents.compactMap {try? $0.data(as: Recent.self)}
                completion(recents)
            }
    }
}
