import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Person: Identifiable, Codable {
    @DocumentID var id: String?
    var username: String
    var email: String
    var avatarLink = ""
    var status = Status()
    static var currentId: String {
        FirebaseClient.shared.person?.id ?? ""
    }
    static var currentName: String {
        FirebaseClient.shared.person?.username ?? ""
    }
    
    struct Status: Codable {
        var index = 0
        var statuses = ["Available", "Busy", "At School"]
        var text: String {
            index < statuses.count ? statuses[index] : "No status"
        }
    }
}
