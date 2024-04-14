import Firebase
import FirebaseFirestore

final class FirebaseClient {
    enum FCollectionReference: String {
        case persons
        case messages
        case channels
    }

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

    func sendMessage(_ message: Message? = nil, recent: Recent) {
        guard let currentId = person?.id else { return }
        do {
            try reference(.messages)
                .document(currentId)
                .collection(recent.chatRoomId)
                .document()
                .setData(from: recent)
            try reference(.messages)
                .document(recent.chatRoomId)
                .collection(currentId)
                .document()
                .setData(from: recent)
        } catch {}

        var data: [String: Any] = [
            "text":             "message.text",
            "username":         recent.username,
            "date":             Date(),
            "avatarLink":       recent.avatarLink,
            "unreadCounter":    0
        ]

        reference(.messages)
            .document(currentId)
            .collection("recents")
            .document(recent.chatRoomId)
            .setData(data)

        data["name"] = person?.username ?? ""
        data["avatarLink"] = person?.avatarLink ?? ""
        reference(.messages)
            .document(recent.chatRoomId)
            .collection("recents")
            .document(currentId)
            .setData(data)
    }

    func downloadRecentChatsFromFireStore(completion: @escaping ([Recent]) -> Void) {
        guard let currentId = person?.id else { return }
        reference(.messages)
            .document(currentId)
            .collection("recents")
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else { return }

                let recents = documents.compactMap {
                    try? $0.data(as: Recent.self)}
                completion(recents)
            }
    }
}
