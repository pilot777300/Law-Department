

import Foundation
import UserNotifications

class NotificationHandler: NSObject, UNUserNotificationCenterDelegate {
    
   // var identifier = "autorized"
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
                  print(userInfo)

        
        
        // Handle the action for when the user taps on the notification
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    func addNotification(content:UNNotificationContent,trigger:UNNotificationTrigger?, indentifier:String){
         let request = UNNotificationRequest(identifier: indentifier, content: content, trigger: trigger)
         UNUserNotificationCenter.current().add(request, withCompletionHandler: {
             (errorObject) in
             if let error = errorObject{
                 print("Error \(error.localizedDescription) in notification \(indentifier)")
             }
         })
     }
}
