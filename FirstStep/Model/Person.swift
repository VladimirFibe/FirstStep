import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Person: Identifiable, Codable {
    @DocumentID var id: String?
    var username: String
    var email: String
    var avatarLink = ""
    var status = 0
    var statuses = ["Available", "Busy", "At School"]
    var current: String {
        if status < statuses.count {
            return statuses[status]
        } else {
            return "no status"
        }
    }
}
