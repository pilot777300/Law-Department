
import Foundation
import SwiftUI
import KeychainSwift

@available(iOS 17.0, *)

@Observable class AppLauncher {
    enum LaunchState {
        case notVerificatedlawyer
        case verificatedLawyer
        case notAutorizedUser
        case autorizedUser
    }
    let network = NetworkManager()
    var launchState = LaunchState.notAutorizedUser
    
    func load() {
//        let keychain = KeychainSwift()
//        if let role = keychain.get("roleLawyer") {
//            if role == "registeredLawyer"{
//                launchState = .notVerificatedlawyer
//            } else if role == "varificatedLawyer" {
//                launchState = .verificatedLawyer
//            }
//        }
        let keychain = KeychainSwift()
        let login = keychain.get("lawyerPhoneNumber") ?? ""
        let password = keychain.get("lawyerPassword") ?? ""
       let model = LawyerInfo(login: login, password: password, token: "", role: "")
      //  func checkLawyerVerification(model: LawyerInfo, completion: @escaping (Result<LawyerToken, AppError>) -> Void) {
            network.chekVerificationOfLawyer(model: model) { [weak self] result in
                Task { @MainActor in
                    switch result {
                    case .success(let token):
                        print(token.token)
                        self?.setKeychain(model: token)
                        self?.launchState = .verificatedLawyer
                    case .failure(_): break
                      //  self?.launchState = .notAutorizedUser
                        //  self?.error = error
                        //  self?.screenstate = .failure
                    }
                }
            }
     //   }
        
    }
    
    func setKeychain(model: LawyerToken) {
        let keychain = KeychainSwift()
        keychain.set(model.token, forKey: "lawyerToken")
        keychain.set("varificatedLawyer", forKey: "roleLawyer")
    }
}
