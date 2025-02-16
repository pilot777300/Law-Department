
import Foundation

struct Order: Identifiable {
    let id = UUID()
    var date: String
    var time: String
    var userName: String
    var phoneNumber: String
    var typeOfHelp: String
}
