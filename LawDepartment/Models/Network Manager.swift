

import Foundation
import KeychainSwift

final class NetworkManager {
    func fetchData <T: Decodable> (urlString: String, completion: @escaping(T) -> ()) {
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { data, responce, error in
            if let error = error {
                print("Failed to fetch data:", error)
                return
            }
            guard let data = data else {
                return
            }
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(object)
                }
            } catch let jsonError {
                print("FAILED TO DECODE", jsonError)
            }
        }.resume()
    }
    
    func sendSms (ApiURL: String, Name: String, City: String, Phone: String)  {
        let url = URL(string: ApiURL)!//URL(string: "https://api.6709.ru/v1/user/client/sign-up")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let newData = Registration(name: Name, patronymic: "", surname: "", city: City, phone: Phone, password: "", verificationCode: "", signUpStage: "SEND_SMS")
        userName = Name // ?
        userCity = City // ?
        userPhone = Phone //?
        
        do {
            let jsonData = try JSONEncoder().encode(newData)
            request.httpBody = jsonData
        } catch let error {
            debugPrint(error.localizedDescription)
        }
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
            } else if let data = data {
                let str = String(data: data, encoding: .utf8)
                print("Received data:\n\(str ?? "")")
            }
        }
        task.resume()
    }
    
    func confirmCode (VerificationCode: String)  {
       // let keychain = KeychainHelper.standart
        let keychain = KeychainSwift()
        let url = URL(string: "https://api.6709.ru/v1/user/client/sign-up")!
        var request = URLRequest(url: url)
        var appState:  AppState //
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let newData = Registration(name: userName, patronymic: "", surname: "", city: userCity, phone: userPhone, password: "123", verificationCode: VerificationCode, signUpStage: "COMPLETE_SIGN_UP")
        let receivedName = userName
        keychain.set(receivedName, forKey: "username")
       // let data = Data(receivedName.utf8)
      //  keychain.save(data, service: "name")
        
        do {
            let jsonData = try JSONEncoder().encode(newData)
            request.httpBody = jsonData
        } catch let error {
            debugPrint(error.localizedDescription)
        }
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
            } else if let data = data {
                let str = String(data: data, encoding: .utf8)
                print("Received data:\n\(str ?? "")")
                
            }
            if let response = response {
                guard let token = try? JSONDecoder().decode(Token.self, from: data!) else { return }  //
           //     userToken = token.token    // ?
                let acessToken = token.token
                keychain.set(acessToken, forKey: "token")
              //  let data = Data(acessToken.utf8)
              //  keychain.save(data, service: "token")
                print(".............access Token:.....")
                print(acessToken)
                print(">>>>>End Of Token>>>>")

            }
        }
        task.resume()
        appState = .autorized //?
        print("APPSTATE = \(appState)")
    }
    
    func checkResponce() -> Bool {
        var isTokenValid = false
        let url = URL(string: "https://api.6709.ru/v1/user/client/sign-up")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { ( data, response, _) in
          
            do {
                let object = try? JSONDecoder().decode(TokenStatus.self, from: data!)
                
            } catch let jsonError {
                print("FAILED TO DECODE", jsonError)
            }
            if let response {
                guard  let object = try? JSONDecoder().decode(TokenStatus.self, from: data!) else { return }
                let isValidToken = object.valid
                isTokenValid = isValidToken
            }
        
        }
       task.resume()
        return isTokenValid
    }
    
//    func sendData ()  {
//        let url = URL(string: "https://jsonplaceholder.typicode.com/todos")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        let loginString = "YourUsername:YourPassword"
//        let loginData = loginString.data(using: String.Encoding.utf8)!
//        let base64LoginString = loginData.base64EncodedString()
////        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
////        request.setValue("Bearer YourToken", forHTTPHeaderField: "Authorization")
////        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        let newTodo = ToDo(userId:  300, title: "My urgent task", completed: false)
//        
//        do {
//            let jsonData = try JSONEncoder().encode(newTodo)
//            request.httpBody = jsonData
//        } catch let error {
//            debugPrint(error.localizedDescription)
//        }
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let error = error {
//                print("Error: \(error)")
//            } else if let data = data {
//                let str = String(data: data, encoding: .utf8)
//                print("Received data:\n\(str ?? "")")
//            }
//        }
//        task.resume()
//    }
}
