
import Foundation
import FirebaseMessaging
import KeychainSwift
import SwiftUI

@MainActor
final class SubscribingToTopics: ObservableObject {
   
   // @ObservedObject  var object: LawyerRegistrationViewModel = .init(service: LawyerRegistrationImplementation())
   
    
     func subscribeToTopic() {
        let keychain = KeychainSwift()
        let lawyerId = keychain.get("PushNotificationId") ?? ""
        let lawyerActivatedTopic = keychain.get("LawyerActivatedTopic") ?? ""
      //  if  isLawyerRegistered == true{
            Messaging.messaging().subscribe(toTopic: "\(lawyerId)") { error in
                print("Subscribed to  topic \(lawyerId)", error?.localizedDescription ?? "NO ERROR")
                
            }
            Messaging.messaging().subscribe(toTopic: "\(lawyerActivatedTopic)") { error in
                print("Subscribed to  topic \(lawyerActivatedTopic)", error?.localizedDescription ?? "NO ERROR")
                
            }
     //   }
    }
}
