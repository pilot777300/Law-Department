
import Foundation

struct Message: Identifiable {
    var id: UUID
    var user: User
    var content: String
}
