
import Foundation
import KeychainSwift

enum UserscreenState {
    case `default`
    case loadind
    case success
    case failure
}

@MainActor
final class UserViewModel: ObservableObject {
    private var network = NetworkManager()
    @Published var screenState: UserscreenState = .default
    @Published var appState: AppState = .notAutorized
    @Published var userName = ""
    @Published var showAlert = false
    @Published var  txt: URL?
    let service: UserVerificationCheck
    var error: AppError?
    init(service: UserVerificationCheck) {
        self.service = service
    }
    
    
    func checkIfUserRegistered() {
        Task {
            let keychain = KeychainSwift()
            let tokenInKeychain = keychain.get("token")
            let usernameInKeychain = keychain.get("username")
            network.checkResponce(token: tokenInKeychain ?? "") { [weak self] result in
               guard let self = self else { return }
                switch result {
                case .success(let tokenStatus):
                    let status = tokenStatus.valid
                    if status == true {
                        DispatchQueue.main.async {
                            self.userName = usernameInKeychain!
                        }
                        appState = .autorized
                        screenState = .success
                    }
                    print("STATUS TOKEN = \(status)")
                  //  print(usernameInKeychain!)
                    print(self.userName)
                    print(self.appState)
                case .failure(_):
                   // screenState = .
                    print("ERROR FROM COMPLETION")
                }
            }
        }
    }
    func deleteUser() {
        Task {
            screenState = .loadind
            let keychain = KeychainSwift()
            let tokenInKeychain = keychain.get("token")
            network.deleteUser(token: tokenInKeychain!)
            deleteUserFromPhone()
        }
    }
    
    func deleteUserFromPhone() {
            let keychain = KeychainSwift()
            let tokenInKeychain = keychain.get("token")
            network.checkResponce(token: tokenInKeychain!) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let tokenStatus):
                    let status = tokenStatus.valid
                    if status == false {
                        service.deleteUserFromKeychain()
                        appState = .notAutorized
                    }
                case .failure(_):
                    break
                }
            }
    }
    func saveDataBeforeClosingView() {
            self.appState = .autorized
    }
  
    
    func sendRequests(adviceType:String) {
        screenState = .loadind
        let keychain = KeychainSwift()
        let token = keychain.get("token")
        let model = AdviceType(adviceType: adviceType)
        network.sendReq(model: model, adviceType: adviceType, token: token!) { [weak self] result in
            switch result {
            case .success(_):
                self?.screenState = .success
                print("SUCCESS FROM COMPL")
            case .failure(_):
                self?.screenState = .failure
                print("ERR FROM COMPL")
            }
        }
    }
    
    
}
                        

