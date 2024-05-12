

import Foundation
import Security

final class KeychainHelper {
    static let standart = KeychainHelper()
    private init() {}
    
    func save(_ token: Data, service: String) {
                let query = [
            kSecValueData: token,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service
        ]
        as CFDictionary
                let status = SecItemAdd(query, nil)
        
        if status != errSecSuccess {
            print("Error: \(status)")
        }
    }
    // using
    // let accessToken = "dummy-access-token"
   // let data = Data(accessToken.utf8)
 //   KeychainHelper.standard.save(data, service: "access-token", account: "facebook")
    
    func read(service: String) -> Data? {
        
        let query = [
            kSecAttrService: service,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ]
        as CFDictionary
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        return (result as? Data)
    }
    // using
  //  let data = KeychainHelper.standard.read(service: "access-token", account: "facebook")!
  //  let accessToken = String(data: data, encoding: .utf8)!
  //  print(accessToken)
    
    func delete(service: String) {
        
        let query = [
            kSecAttrService: service,
            kSecClass: kSecClassGenericPassword,
            ] as CFDictionary
                SecItemDelete(query)
    }
}
