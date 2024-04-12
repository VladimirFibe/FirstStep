import Foundation

protocol ProfileStatusServiceProtocol {
    func updateStatus(_ status: Person.Status)
}

extension FirebaseClient: ProfileStatusServiceProtocol {
    func updateStatus(_ status: Person.Status) {
        guard let uid = person?.id else { return }
        person?.status = status
        reference(.persons)
            .document(uid)
            .updateData(["status": ["index": status.index, "statuses": status.statuses]])
    }
    

}
