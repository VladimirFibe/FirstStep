import Firebase
import FirebaseFirestore

final class FirebaseClient {
    static let shared = FirebaseClient()
    private init() {}

    func createPerson(withEmail email: String, uid: String) throws {
        let person = Person(username: email, email: email)
        try reference(.persons).document(uid).setData(from: person)
    }

    func reference(_ collectionReference: FCollectionReference) -> CollectionReference {
        Firestore.firestore().collection(collectionReference.rawValue)
    }

    enum FCollectionReference: String {
        case persons
        case messages
        case channels
    }
}
