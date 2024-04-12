import Foundation
import FirebaseAuth

protocol UsersServiceProtocol {
    func fetchPersons() async throws -> [Person]
}

extension FirebaseClient: UsersServiceProtocol {
    func fetchPersons() async throws -> [Person] {
        guard let id = Auth.auth().currentUser?.uid else { return [] }
        let query = try await reference(.persons).limit(to: 10).getDocuments()
        var persons = query.documents.compactMap { try? $0.data(as: Person.self)}
        persons = persons.filter({$0.id != id})
        return persons
    }
}
