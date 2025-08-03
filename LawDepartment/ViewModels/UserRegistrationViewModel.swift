
import Foundation
import KeychainSwift

enum UserRegistrationScreenState {
    case `default`
    case loadind
    case invalidForm
    case success
    case error
}

@MainActor
final class UserRegistrationViewModel: ObservableObject {
    
    var error: AppError?
    let internet = NetworkManager()
    @Published var screenState: UserRegistrationScreenState = .default
    @Published  var userName: String = ""
    @Published  var userCity: String = ""
    @Published  var userPhoneNumber: String = "+7"
    
    func sendSms() {
        Task {
            guard validateRegistrationForm() else {
                screenState = .invalidForm
                return
            }
            
            screenState = .loadind
            let keychain = KeychainSwift()
            let notFormattedPhoneNumber = userPhoneNumber.replacingOccurrences(of: " ", with: "")
            let intermediateFormatting = notFormattedPhoneNumber.replacingOccurrences(of: "+", with: "")
            let formattedPhoneNumber = intermediateFormatting.replacingOccurrences(of: "-", with: "")
            let model = UserRegistration(name: userName, patronymic: "", surname: "", city: userCity, phone: formattedPhoneNumber, password: "", verificationCode: "", signUpStage: "SEND_SMS")
            keychain.set(userName, forKey: "username")
            keychain.set(userCity, forKey: "usercity")
            keychain.set(formattedPhoneNumber, forKey: "userPhoneNumber")
            internet.sendSmsToConfirm(model: model) { [weak self] result  in
                guard let self = self else {return}
                switch result {
                case .success(_):
                    screenState = .success
                case .failure(let error):
                    self.error = error
                    screenState = .error
                }
            }
        }
    }
    
    private func validateRegistrationForm() -> Bool {
        if userName == "" || userCity == "" || userPhoneNumber == "" {
            return false
        }
        return true
    }
}
