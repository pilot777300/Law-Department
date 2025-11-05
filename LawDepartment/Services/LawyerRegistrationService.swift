
import Foundation
import KeychainSwift
import FirebaseMessaging

protocol LawyerRegistrationService {
    func registerLawyer(model: Lawyer, completion: @escaping(Result<LawyerTokenStatus, AppError>) -> Void)
}


final class LawyerRegistrationImplementation: LawyerRegistrationService {
    private let network = NetworkManager()
    
    
    func registerLawyer(model: Lawyer, completion: @escaping (Result<LawyerTokenStatus, AppError>) -> Void) {
        network.regiterLawyer(model: model) { [weak self] result in
            switch result {
            case .success(let tokenModel):
                self?.setKeychain(model: model)
                self?.setLawyerIdForPushNotifications(model: tokenModel)
                self?.subscribeToFirebaseTopics()
                completion(.success(tokenModel))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func setKeychain(model: Lawyer) {
        let keychain = KeychainSwift()
        keychain.set("registeredLawyer", forKey: "roleLawyer")
        keychain.set(model.name, forKey: "lawyerName")
        keychain.set(model.patronymic, forKey: "lawyerPatronymic")
        keychain.set(model.surname, forKey: "lawyerSurname")
        keychain.set(model.phone, forKey: "lawyerPhoneNumber")
        keychain.set(model.password, forKey: "lawyerPassword")
    }
 
    private func setLawyerIdForPushNotifications(model: LawyerTokenStatus) {
       let keychain = KeychainSwift()
        keychain.set(model.newRequestTopic, forKey: "PushNotificationId")
        keychain.set(model.lawyerActivatedTopic, forKey: "LawyerActivatedTopic")
    }
    
    private  func subscribeToFirebaseTopics() {
       let keychain = KeychainSwift()
       let lawyerId = keychain.get("PushNotificationId") ?? ""
       let lawyerActivatedTopic = keychain.get("LawyerActivatedTopic") ?? ""
           Messaging.messaging().subscribe(toTopic: "\(lawyerId)") { error in
               print("Subscribed to  topic \(lawyerId)", error?.localizedDescription ?? "NO ERROR")
               
           }
           Messaging.messaging().subscribe(toTopic: "\(lawyerActivatedTopic)") { error in
               print("Subscribed to  topic \(lawyerActivatedTopic)", error?.localizedDescription ?? "NO ERROR")
           }
   }
    
    
}
