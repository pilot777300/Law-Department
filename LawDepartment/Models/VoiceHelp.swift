
import Foundation

struct VoiceHelp: Codable {
    let requestId: String
    let adviceType: String
    let  confirmed: Bool
    let  closed: Bool
    let  sentAt: String
    let lawyerName: String
    let lawyerPatronymic: String
    let lawyerSurname: String
    let lawyerCity: String
    let lawyerPhone: String
}
