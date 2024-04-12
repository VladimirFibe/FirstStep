import Foundation

protocol UsersUseCaseProtocol {
    func fetchPersons() async throws -> [Person]
}
final class UsersUseCase: UsersUseCaseProtocol {
    private let apiService: UsersServiceProtocol
    init(apiService: UsersServiceProtocol) {
        self.apiService = apiService
    }
    func fetchPersons() async throws -> [Person] {
        try await apiService.fetchPersons()
    }
}
