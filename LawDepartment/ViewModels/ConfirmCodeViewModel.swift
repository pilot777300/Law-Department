
import Foundation
import KeychainSwift

@MainActor
final class ConfirmCodeViewModel: ObservableObject {
    @Published var pinOne: String = ""
    @Published var pinTwo: String = ""
    @Published var pinThree: String = ""
    @Published var pinFour: String = ""
    @Published var pinFive: String = ""
    @Published var pinSix: String = ""
    @Published var isShowChoiseScreen = false

    @Published var appState: AppState = .notAutorized

    private let service: ConfirmSms
    init(service: ConfirmSms) {
        self.service = service
    }
    func confirmSmsCode() {
        Task {
            let keychain = KeychainSwift()
            let name = keychain.get("username")
            let city = keychain.get("usercity")
            let phone = keychain.get("userPhoneNumber")
           let codeFromSms = pinOne + pinTwo + pinThree + pinFour + pinFive + pinSix
            let model = UserRegistration(name: name!, patronymic: "", surname: "", city: city!, phone: phone!, password: "123", verificationCode: codeFromSms, signUpStage: "COMPLETE_SIGN_UP")
            service.confirmSms(model: model) { [weak self] result in
                switch result {
                case (.success(let token)):
                    self?.appState = .autorized
                    self?.isShowChoiseScreen = true
                case(.failure(let error)):
                    print("ERROR FROM COMPL")
                }
            }
        }
        
    }
}
