

import Foundation
import KeychainSwift

final class UserVerificationCheck {
    func deleteUserFromKeychain() {
        let keychain = KeychainSwift()
         keychain.delete("token")
        keychain.delete("username")
        keychain.delete("usercity")
        keychain.delete("userPhoneNumber")
    }
}
