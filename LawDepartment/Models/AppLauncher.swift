
import Foundation
import SwiftUI
import KeychainSwift

@available(iOS 17.0, *)
@Observable class AppLauncher {
    enum LaunchState {
        case notVerificatedlawyer
        case verificatedLawyer
        case notAutorizedUser
        case autorizedUser
    }
    var launchState = LaunchState.notAutorizedUser
    
    func load() {
        let keychain = KeychainSwift()
        if let role = keychain.get("roleLawyer") {
            if role == "registeredLawyer"{
                launchState = .notVerificatedlawyer
            } else if role == "varificatedLawyer" {
                launchState = .verificatedLawyer
            }
        }
            
        
    }
}
