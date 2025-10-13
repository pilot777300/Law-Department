

import SwiftUI
import KeychainSwift
import Firebase
import FirebaseMessaging
import FirebaseCore
import UserNotifications


@available(iOS 17.0, *)

class AppDelegate: NSObject, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate{
    let keychain = KeychainSwift()
    let gcmMessageIDKey = "gcm.message_id"
    let clientRequest = "clientRequest"
    let type = "adviceType"
    
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      application.registerForRemoteNotifications()
              FirebaseApp.configure()
              Messaging.messaging().delegate = self
              UNUserNotificationCenter.current().delegate = self
      return true
  }

    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
       Messaging.messaging().appDidReceiveMessage(userInfo)

        let content = UNMutableNotificationContent()
          content.title = "Новая заявка"
          content.body = "Поступила новая заявка на консультацию"
          content.sound = .default
          let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
          let request = UNNotificationRequest(identifier: "testNotification", content: content, trigger: trigger)
          UNUserNotificationCenter.current().add(request) { error in
              if let error = error {
                  print("Error sending notification: \(error.localizedDescription)")
              }
          }

        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
          Messaging.messaging().apnsToken = deviceToken
        let lawyerId = keychain.get("PushNotificationId") ?? ""
        DispatchQueue.main.async{
            Messaging.messaging().subscribe(toTopic: "\(lawyerId)") { error in
              // print("Subscribed to  topic", error?.localizedDescription ?? "NO ERROR")
              //  print("\(lawyerId)" ?? "NO ERROR")
            }
        }
      }
      
      
      func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
          if let fcm = Messaging.messaging().fcmToken {
            //  print("fcm", fcm)
          }
      }
    
}

@main
struct LawDepartmentApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State private var launcher = AppLauncher()
    
//    init() {
//        let notificationHandler = NotificationHandler()
//        UNUserNotificationCenter.current().delegate = notificationHandler
//            FirebaseApp.configure()
//            registerForPushNotifications()
//        }
    
    var body: some Scene {
        WindowGroup {
            bodyContentView(launchState: launcher.launchState)
                .onAppear{ launcher.load()}
            
        //    FirstAutorizationScreen()
        //   AuthorizedUserMainScreen()
      //      OnBoardingScreen(state: .onbrd)
          //  UserAutorizationScreen()
           // LawyerMainScreen()
          //  LawyerStartigScreen()
          //  OrdersScreen()
          //  OtpFormFieldView()
          //  OtpFormFieldView()
        }
    }
    @available(iOS 17.0, *)
    @ViewBuilder private func bodyContentView(launchState: AppLauncher.LaunchState) -> some View {
        switch launchState {
        case .notVerificatedlawyer:
            OnBoardingForLawyerScreen()
        case .notAutorizedUser:
            AuthorizedUserMainScreen()
       case .verificatedLawyer:
            LawyerStartigScreen()
        case .autorizedUser:
            AuthorizedUserMainScreen()
        }
    }
    
//    private func registerForPushNotifications() {
//         let center = UNUserNotificationCenter.current()
//         center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
//             if granted {
//                 DispatchQueue.main.async {
//                     UIApplication.shared.registerForRemoteNotifications()
//                 }
//                 let string = "80a84e6cfdb4d25f23cfc02f925445b3f14b059e5466a674620fb43592c499b0d721868705a3f3521af8c5ca82e89332e95b3c26a75f1e4b13c8ece96acdd4b97158ee9f7625b94b91bc06a409621662"
//                      let unicode = string.data(using: .unicode)
//                      Messaging.messaging().apnsToken = unicode
//             }
//         }
//     }
}
