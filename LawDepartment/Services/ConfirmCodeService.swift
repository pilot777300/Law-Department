

import Foundation
import KeychainSwift

protocol ConfirmSms {
    func confirmSms(model: UserRegistration, completion: @escaping(Result<Token, AppError>) -> Void)
}

final class UserRegistrationService: ConfirmSms {
    private let internet = NetworkManager()
    func confirmSms(model: UserRegistration, completion: @escaping (Result<Token, AppError>) -> Void) {
        internet.confirmCode(model: model) { [weak self]  result in
            switch result {
            case (.success(let token)):
                self?.setKeychain(token: token, model: model)
                completion(.success(token))
            case(.failure(let error)):
                print("ERROOR FROM COMPLETION CONFIRM CODE")
            }
        }
    }
    
    func setKeychain(token: Token, model: UserRegistration) {
        let keychain = KeychainSwift()
        keychain.set(token.token, forKey: "token")
        keychain.set("autorizedUser", forKey: "userRole")
       // keychain.set(model.name, forKey: "username")
    }
}
