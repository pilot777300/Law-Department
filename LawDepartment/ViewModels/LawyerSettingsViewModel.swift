
import Foundation
import KeychainSwift

@MainActor
final class LawyerSettingsViewModel: ObservableObject {
    
    @Published  var name = ""
    @Published  var patronymic = ""
    @Published  var surname = ""
    
    func deleteLawyer() {
            let network = NetworkManager()
            let keychain = KeychainSwift()
            let token = keychain.get("lawyerToken")
            network.deleteLawyer(token: token!)
        deleteLawyerFromKeychain()
    }
    func deleteLawyerFromKeychain() {
        let keychain = KeychainSwift()
        keychain.delete("roleLawyer")
        keychain.delete("lawyerToken")
        keychain.delete("lawyerName")
        keychain.delete("lawyerPatronymic")
        keychain.delete("lawyerSurname")
        keychain.delete("lawyerPhoneNumber")
        keychain.delete("lawyerPassword")
    }
       
    func fillLawyerSettings() {
            let keychain = KeychainSwift()
            name = keychain.get("lawyerName") ?? "Пользователь"
            patronymic = keychain.get("lawyerPatronymic") ?? "не"
            surname = keychain.get("lawyerSurname") ?? "авторизован"
       }
    }

