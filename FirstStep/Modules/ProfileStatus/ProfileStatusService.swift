import Foundation

protocol ProfileStatusServiceProtocol {
    func updateStatus(statuses: [String], current: Int)
}

extension FirebaseClient: ProfileStatusServiceProtocol {
    func updateStatus(statuses: [String], current: Int) {
        guard let uid = person?.id else { return }
        person?.status = current
        person?.statuses = statuses
        reference(.persons)
            .document(uid)
            .updateData(["statuses": statuses, "status": current])
    }
    

}
