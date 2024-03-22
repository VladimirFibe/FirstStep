import Foundation

protocol AuthUseCaseProtocol {
}
final class AuthUseCase: AuthUseCaseProtocol {
    private let apiService: AuthServiceProtocol

    init(apiService: AuthServiceProtocol) {
        self.apiService = apiService
    }
}
