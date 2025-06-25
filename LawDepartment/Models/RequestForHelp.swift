
import Foundation

struct RequestForHelp: Codable {
   var requestId: String
    var adviceType: String
    var takenToWork: Bool
    var serviceProvided: Bool
    var closed: Bool
    var sentAt: String
//    var lawyerName: String
//    var lawyerPatronymic: String
//    var lawyerSurname: String
//    var lawyerCity: String
//    var lawyerPhone: String
}
