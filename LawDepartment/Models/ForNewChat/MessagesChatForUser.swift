import Foundation

struct MessageChatForUser: Hashable, Codable {
   // var fromUserName: String
   var text: String
    var sentAt: String
   var sendByMe: Bool
}
