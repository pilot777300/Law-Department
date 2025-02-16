
import Foundation

struct RequestForHelp: Codable {
   var requestId: String
    var adviceType: String
    var confirmed: Bool
    var closed: Bool
    var sentAt: String
    var lawyerName: String
    var lawyerPatronymic: String
    var lawyerSurname: String
    var lawyerCity: String
    var lawyerPhone: String
}
