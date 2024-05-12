

import Foundation

struct Registration: Codable {
    var name: String
    var patronymic: String
    var surname: String
    var city: String
    var phone: String
    var password: String
    var verificationCode: String
    var signUpStage: String
}
