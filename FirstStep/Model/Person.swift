import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Person: Identifiable, Codable {
    @DocumentID var id: String?
    var username: String
    var email: String
    var avatarLink = ""
    var status = Status()

    struct Status: Codable {
        var index = 0
        var statuses = ["Available", "Busy", "At School"]

        var text: String {
            index < statuses.count ? statuses[index] : "No status"
        }
    }
}
