
import Foundation
import KeychainSwift



@MainActor
final class UserRegistrationViewModel: ObservableObject {
    var error: AppError?
    let internet = NetworkManager()
    @Published  var userName: String = ""
    @Published  var userCity: String = ""
    @Published  var userPhoneNumber: String = "+7"
    @Published  var showConfirmSmsScreen = false
    
    func sendSms() {
        Task {
            let keychain = KeychainSwift()
            let notFormattedPhoneNumber = userPhoneNumber.replacingOccurrences(of: " ", with: "")
            let intermediateFormatting = notFormattedPhoneNumber.replacingOccurrences(of: "+", with: "")
            let formattedPhoneNumber = intermediateFormatting.replacingOccurrences(of: "-", with: "")
            let model = UserRegistration(name: userName, patronymic: "", surname: "", city: userCity, phone: formattedPhoneNumber, password: "", verificationCode: "", signUpStage: "SEND_SMS")
            keychain.set(userName, forKey: "username")
            keychain.set(userCity, forKey: "usercity")
            keychain.set(formattedPhoneNumber, forKey: "userPhoneNumber")
            internet.sendSms(model: model)
            showConfirmSmsScreen = true
        }
    }
}
