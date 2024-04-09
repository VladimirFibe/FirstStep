import Foundation

protocol EditProfileServiceProtocol {
    func fetchPerson() async throws
}

extension FirebaseClient: EditProfileServiceProtocol {
    
}
