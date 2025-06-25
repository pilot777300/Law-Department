
import Foundation
import KeychainSwift

@MainActor
final class UserViewModel: ObservableObject {
    private var network = NetworkManager()
    @Published var appState: AppState = .notAutorized
    @Published var userName = ""
    @Published var showAlert = false
    @Published var  txt: URL?
    let service: UserVerificationCheck
    
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
                        self.appState = .autorized
                    }
                    print("STATUS TOKEN = \(status)")
                    print(usernameInKeychain!)
                    print(self.userName)
                    print(self.appState)
                case .failure(let error):
                    print("ERROR FROM COMPLETION")
                }
            }
        }
    }
    func deleteUser() {
        Task {
            let keychain = KeychainSwift()
            let tokenInKeychain = keychain.get("token")
            network.deleteUser(token: tokenInKeychain!)
           // self.userName = ""
        }
    }
    
    func deleteUserFromPhone() {
     //   Task{
            let keychain = KeychainSwift()
            let tokenInKeychain = keychain.get("token")
            network.checkResponce(token: tokenInKeychain!) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let tokenStatus):
                    let status = tokenStatus.valid
                    if status == false {
                        self.service.deleteUserFromKeychain()
                        self.appState = .notAutorized
                    }
                case .failure(let error):
                    print("ERROR FROM DELETING COMPLETION")
                }
            }
       // }
    }
    func saveDataBeforeClosingView() {
            self.appState = .autorized
    }
  
    
    func sendRequests(adviceType:String) {
        let keychain = KeychainSwift()
        let token = keychain.get("token")
      //  let date = Date()
      //  let identifier = UUID().uuidString
        let model = AdviceType(adviceType: adviceType)
        network.sendReq(model: model, adviceType: adviceType, token: token!) { [weak self] result in
            switch result {
            case .success(let request):
                print("SUCCESS FROM COMPL")
            case .failure(let error):
                print("ERR FROM COMPL")
            }
        }
    }
}
                        

