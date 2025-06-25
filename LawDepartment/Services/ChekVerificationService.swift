

import Foundation
import KeychainSwift

protocol ChekVerificationService {
    func checkLawyerVerification(model: LawyerInfo, completion: @escaping(Result<LawyerToken, AppError>) -> Void)
    
}

final class VerificationChecker: ChekVerificationService {
    let network = NetworkManager()
    func checkLawyerVerification(model: LawyerInfo, completion: @escaping (Result<LawyerToken, AppError>) -> Void) {
        network.chekVerificationOfLawyer(model: model) { [weak self] result  in
            switch result {
            case .success(let token):
                self?.setKeychain(model: token)
                completion(.success(token))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func setKeychain(model: LawyerToken) {
        let keychain = KeychainSwift()
        keychain.set(model.token, forKey: "lawyerToken")
        keychain.set("varificatedLawyer", forKey: "roleLawyer")  
    }
}
