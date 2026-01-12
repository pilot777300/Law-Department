

import Foundation
import SwiftUI
import KeychainSwift


enum UserChatScreenState {
    case `default`
    case loading
    case success
    case failure
}

@MainActor
final class ChatViewModel: ObservableObject {
    
    @Published var screenState: UserChatScreenState = .default
    @Published var userName: String = "Задать вопрос адвокату"
   // @Published var appState: AppState? //= .notAutorized
    @Published var appLauncher: AppLauncher?
    @Published var typingMessage: String = ""
    @Published var isUserTyping: Bool = false
    @Published var messages = ["Добрый день! Я дежурный юрист Игорь Николаевич. Какой у вас вопрос? "]
   // @Published var incomingMessagedg = [String]()
   // @Published var outgoingMessage = [String]()
    
    var error: AppError?
    let keychain = KeychainSwift()
    let network = NetworkManager()

    
    func sendMessage(message: String) {
        Task {
            let model = UserChatMessage(text: message)
            let tokenInKeychain = keychain.get("token")
            network.sendMessagetoLawyer(token: tokenInKeychain ?? "", model: model) { [weak self] result in
                Task { @MainActor in
                    switch result {
                    case .success(let messaging):
                        self?.screenState = .success
                       // self?.outgoingMessage.append(messaging.text)
                        self?.messages.append(messaging.text)
                        self?.isUserTyping = true
                        print(messaging.text)
                    case .failure( let error):
                        self?.screenState = .failure
                        self?.error = error
                    }
                }
            }
        }
    }
    
//    func checkIfUserRegistered() {
//        Task {
//            screenState = .loading
//            let tokenInKeychain = keychain.get("token")
//            let usernameInKeychain = keychain.get("username")
//            network.checkResponce(token: tokenInKeychain ?? "") { [weak self] result in
//               guard let self = self else { return }
//                switch result {
//                case .success(let tokenStatus):
//                    let status = tokenStatus.valid
//                    if status == true {
//                        appState = .autorized
//                        screenState = .success
//                    }
//                case .failure(_):
//                    screenState = .failure
//                }
//            }
//        }
//    }
}
