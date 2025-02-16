

import Foundation
import KeychainSwift

final class NetworkManager: ObservableObject {
    
    @Published var appState: AppState = .notAutorized
    
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
        let url = URL(string: ApiURL)!
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
        let keychain = KeychainSwift()
        let url = URL(string: "https://api.6709.ru/v1/user/client/sign-up")!
        var request = URLRequest(url: url)
        self.appState = .autorized
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let newData = Registration(name: userName, patronymic: "", surname: "", city: userCity, phone: userPhone, password: "123", verificationCode: VerificationCode, signUpStage: "COMPLETE_SIGN_UP")
        let receivedName = userName
        keychain.set(receivedName, forKey: "username")
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
                let acessToken = token.token
                keychain.set(acessToken, forKey: "token")
            }
        }
        task.resume()
    }
    
    func checkResponce(Token:String) {
        let url = URL(string: "https://api.6709.ru/v1/user/token-status?token=\(Token)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"  
        let task = URLSession.shared.dataTask(with: request) { ( data, response, _) in
            do {
                let object = try? JSONDecoder().decode(TokenStatus.self, from: data!)
             
            } catch let jsonError {
                print("FAILED to DECODE", jsonError)
            }
            if let response {
                guard  let object = try? JSONDecoder().decode(TokenStatus.self, from: data!) else { return }
                let isValidToken = object.valid
                print("VALID: \(isValidToken)")
            }
        }
       task.resume()
    }
    
    func deleteUser() {
        let keychain = KeychainSwift()
        let token = keychain.get("token")
       // keychain.delete("username")
      //  keychain.delete("token")
        self.appState = .notAutorized
        let url = URL(string: "https://api.6709.ru/v1/client")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("Bearer \(String(describing: token))", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            guard error == nil else {
                print("Error: error calling DELETE")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                          print("Error: HTTP request failed")
                          return
                      }
            do {
                          guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                              print("Error: Cannot convert data to JSON")
                              return
                          }
                          guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                              print("Error: Cannot convert JSON object to Pretty JSON data")
                              return
                          }
                          guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                              print("Error: Could print JSON in String")
                              return
                          }
                          
                          print(prettyPrintedJson)
                      } catch {
                          print("Error: Trying to convert JSON data to string")
                          return
                      }
        }
        task.resume()
        keychain.delete("username")
        keychain.delete("token")
    }
    
    func sendRequestForHelp(AdviceType: String) {
        let url = URL(string: "https://api.6709.ru/v1/client/requests")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let date = Date()
        let identifier = UUID()
        let newData = RequestForHelp(requestId: identifier.uuidString, adviceType: AdviceType, confirmed: true, closed: false, sentAt: date.formatted(date: .long, time: .shortened), lawyerName: "", lawyerPatronymic: "", lawyerSurname: "", lawyerCity: "", lawyerPhone: "")
        do {
            let jsonData = try JSONEncoder().encode(newData)
            request.httpBody = jsonData
        } catch let error{
            debugPrint(error.localizedDescription)
        }
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let error = error {
                print("ERROR: \(error)")
            }
            else if let data = data {
                let str = String(data: data, encoding: .utf8)
                print("Received data:\n\(str ?? "")")
                
            }
            if let response = response {
                guard let temporaryInformation = try? JSONDecoder().decode(RequestForHelp.self, from: data!) else {return}
                print("ADVICETYPE: \(temporaryInformation.adviceType)")
                print("DATE: \(temporaryInformation.requestId)")
                print("ID: \(temporaryInformation.requestId)")
            }
        }
        task.resume()
    }
}
