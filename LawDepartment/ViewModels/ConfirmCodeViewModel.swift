
import Foundation
import KeychainSwift

enum ComfirmCodeScreenState {
    case `default`
    case loading
    case sucess
    case invalidForm
    case error
}

@MainActor
final class ConfirmCodeViewModel: ObservableObject {
    @Published var pinOne: String = ""
    @Published var pinTwo: String = ""
    @Published var pinThree: String = ""
    @Published var pinFour: String = ""
    @Published var pinFive: String = ""
    @Published var pinSix: String = ""
  //  @Published var isShowChoiseScreen = false
    @Published var screenState: ComfirmCodeScreenState = .default
    @Published var appState: AppState = .notAutorized
    var error: AppError?

    private let service: ConfirmSms
    init(service: ConfirmSms) {
        self.service = service
    }
    func confirmSmsCode() {
        Task {
            guard checkIfFormIsEmpty() else {
                self.screenState = .invalidForm
                return
            }
            screenState = .loading
            let keychain = KeychainSwift()
            let name = keychain.get("username")
            let city = keychain.get("usercity")
            let phone = keychain.get("userPhoneNumber")
           let codeFromSms = pinOne + pinTwo + pinThree + pinFour + pinFive + pinSix
            let model = UserRegistration(name: name!, patronymic: "", surname: "", city: city!, phone: phone!, password: "123", verificationCode: codeFromSms, signUpStage: "COMPLETE_SIGN_UP")
            service.confirmSms(model: model) { [weak self] result in
                switch result {
                case (.success(_)):
                        self?.screenState = .sucess
                        self?.appState = .autorized
                case(.failure(let error)):
                    self?.error = error
                    self?.screenState = .error
                    print("ERROR FROM COMPL")
                }
            }
        }
        
    }
    
    private func checkIfFormIsEmpty() -> Bool {
        if pinOne == "" || pinTwo == "" || pinThree == "" || pinFour == "" || pinFive == "" || pinSix == "" {
         return false
        }
        return true
    }
}
