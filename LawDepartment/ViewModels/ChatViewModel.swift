

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
    @Published var lawyerName: String = "Дежурный адвокат (г.Москва)"
    @Published var pageNumber = 0
    @Published var pageSize = 30
    @Published var appLauncher: AppLauncher?
    @Published var typingMessage: String = ""
    @Published var isUserTyping: Bool = false
    @Published var messages = [MessageChatForUser]()  // = [MessageChatForUser(text: "Здравствуйте, сегодня я дежурный адвокат. Какой у вас вопрос?",
                                                                       // sentAt: "", sendByMe: false)]
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
    
    func fetchMessages() {
        Task {
            screenState = .loading
            let tokenInKeychain = keychain.get("token")
            network.fetchMessagesFromLawyer(token: tokenInKeychain ?? "", pageNumber: self.pageNumber, pageSize: self.pageSize) { [weak self] result in
                Task { @MainActor in
                switch result {
                case .success(let messages):
                    var localArray: [MessageChatForUser] = []
                    for i in messages {
                        let model = MessageChatForUser(text: i.text, sentAt: i.sentAt, sendByMe: i.sendByMe)
                        localArray.append(model)
                        self?.messages = localArray
                        self?.screenState = .success
                    }
                case .failure(let error):
                    self?.screenState = .failure
                    self?.error = error
              }
            }
          }
       }
    }
 }
