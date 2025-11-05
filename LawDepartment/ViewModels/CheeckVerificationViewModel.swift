

import Foundation
import KeychainSwift
import FirebaseMessaging

enum CheckLawyerVerification {
    case `default`
    case loadind
    case success
    case failure
}

@MainActor
final class CheckVerificationViewModel: ObservableObject {
    @Published var screenstate: CheckLawyerVerification = .default
    var error: AppError?
   // @Published var isLawyerVerificated = false
    private let service: VerificationChecker
    
    init(service: VerificationChecker) {
        self.service = service
    }
    
    func checkVerivication() {
        Task {
            screenstate = .loadind
             let keychain = KeychainSwift()
             let login = keychain.get("lawyerPhoneNumber") ?? ""
             let password = keychain.get("lawyerPassword") ?? ""
            let model = LawyerInfo(login: login, password: password, token: "", role: "")
            service.checkLawyerVerification(model: model) { [weak self] result in
                Task { @MainActor in
                    switch result {
                    case .success(let token):
                         print(token.token)
                      //  self?.isLawyerVerificated = true
                        self?.screenstate = .success
                    case .failure(let error):
                        self?.error = error
                        self?.screenstate = .failure
                    }
                }
            }
        }
    }
    
//    func subscribeToFirebaseTopics() {
//       let keychain = KeychainSwift()
//       let lawyerId = keychain.get("PushNotificationId") ?? ""
//       let lawyerActivatedTopic = keychain.get("LawyerActivatedTopic") ?? ""
//           Messaging.messaging().subscribe(toTopic: "\(lawyerId)") { error in
//               print("Subscribed to  topic \(lawyerId)", error?.localizedDescription ?? "NO ERROR")
//               
//           }
//           Messaging.messaging().subscribe(toTopic: "\(lawyerActivatedTopic)") { error in
//               print("Subscribed to  topic \(lawyerActivatedTopic)", error?.localizedDescription ?? "NO ERROR")
//               
//           }
//   }
    
}
