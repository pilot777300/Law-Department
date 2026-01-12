
import Foundation

struct MessageFromUser:  Hashable, Codable {
   var fromUserId: Int
  // var messageId: String
    var fromUserName: String
   var text: String
    var sentAt: String
 // var wasReadByRecipient: Bool
   var sendByMe: Bool
}
