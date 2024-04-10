import Foundation

protocol EditProfileServiceProtocol {
    func fetchPerson() async throws
    func updateUsername(_ username: String)
    func updateAvatar(_ avatarLink: String)
}

extension FirebaseClient: EditProfileServiceProtocol {
    func updateUsername(_ username: String) {
        person?.username = username
        updateField("username", value: username)
    }

    func updateAvatar(_ avatarLink: String) {
        person?.avatarLink = avatarLink
        updateField("avatarLink", value: avatarLink)
    }

    func updateField(_ key: String, value: String) {
        guard let uid = person?.id else { return }
        reference(.persons)
            .document(uid)
            .updateData([key: value])
    }
}
