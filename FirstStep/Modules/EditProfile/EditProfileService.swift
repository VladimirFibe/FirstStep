import Foundation

protocol EditProfileServiceProtocol {
    func fetchPerson() async throws
    func updateUsername(_ username: String)
}

extension FirebaseClient: EditProfileServiceProtocol {
    func updateUsername(_ username: String) {
        guard let uid = person?.id else { return }
        person?.username = username
        reference(.persons)
            .document(uid)
            .updateData(["username": username])
    }
}
