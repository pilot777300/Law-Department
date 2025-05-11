
import Foundation

struct Order: Codable, Identifiable {
    var id = UUID()
    var clientRequestId: String
    var adviceType: String
    var sentAt: String
    var clientName: String
    var clientPhone: String
    var isNew: Bool
    var takenToWork: Bool
    var serviceProvided: Bool
    var closed: Bool
}
