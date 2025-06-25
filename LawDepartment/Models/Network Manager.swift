

import Foundation
import KeychainSwift


enum AppError: Error {
    case internetConnectiomProblem
    case parsingError
    case serverError(ErrorModel)
    case unknown
}

struct ErrorModel: Decodable, Error {
    var error: String
}

final class NetworkManager: ObservableObject {

    @Published var appState: AppState = .notAutorized
   @Published var isLawyerAlreadyVerificated = false
    
   
    
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
    
    func sendSms (model: UserRegistration)  {
        let url = URL(string: "https://api.6709.ru/v1/user/client/sign-up")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
       // let newData = UserRegistration(name: Name, patronymic: "", surname: "", city: City, phone: Phone, password: "", verificationCode: "", signUpStage: "SEND_SMS")
      //  userName = Name
     //   userCity = City
     //   userPhone = Phone
        do {
              let jsonData = try JSONEncoder().encode(model)
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
    
    func confirmCode (model: UserRegistration, completion: @escaping(Result<Token, AppError>) -> Void)  {
      //  let keychain = KeychainSwift()
        let url = URL(string: "https://api.6709.ru/v1/user/client/sign-up")!
        var request = URLRequest(url: url)
      //  self.appState = .autorized
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      //  let newData = UserRegistration(name: userName, patronymic: "", surname: "", city: userCity, phone: userPhone, password: "123", verificationCode: VerificationCode, signUpStage: "COMPLETE_SIGN_UP")
      //  let receivedName = userName
       // keychain.set(receivedName, forKey: "username")
        do {
            let jsonData = try JSONEncoder().encode(model)
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
               // let acessToken = token.token
              //  keychain.set(acessToken, forKey: "token")
             //   keychain.set("autorizedUser", forKey: "userRole")
                completion(.success(token))
            }
        }
        task.resume()
    }
    
    func checkResponce(token:String, completion: @escaping (Result<TokenStatus,AppError>) -> Void) {
        let url = URL(string: "https://api.6709.ru/v1/user/token-status?token=\(token)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { ( data, response, error) in
            do {
                let object = try? JSONDecoder().decode(TokenStatus.self, from: data!)
                
            } catch let error {
                completion(.failure(AppError.parsingError))
               print("FAILED to DECODE", error)
            }
            if let data = data {
                guard  let tokenStatus = try? JSONDecoder().decode(TokenStatus.self, from: data) else { return }
//                let isValidToken = object.valid
//                if isValidToken == true {
//                    self.appState = .autorized
//                }
                DispatchQueue.main.async {
                    completion(.success(tokenStatus))
                }
            }
        }
        task.resume()
    }
    
    func deleteUser(token: String) {
      //  let keychain = KeychainSwift()
      //  let token = keychain.get("token")
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
      //  keychain.delete("username")
    // keychain.delete("token")
     //   keychain.delete("userRole")
    }
    
    
    func sendReq (model: AdviceType, adviceType:String, token: String,  completion: @escaping(Result<RequestForHelp, AppError>) -> Void)  {
        let url = URL(string: "https://api.6709.ru/v1/client/requests")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(String(describing: token))", forHTTPHeaderField: "Authorization")
        do {
            let jsonData = try JSONEncoder().encode(model)
            request.httpBody = jsonData
        } catch let error{
            debugPrint(error.localizedDescription)
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("ERROR: \(error)")
                switch error {
                case URLError.timedOut,
                    URLError.notConnectedToInternet,
                    URLError.networkConnectionLost,
                    URLError.cannotFindHost:
                    completion(.failure(AppError.internetConnectiomProblem))
                case URLError.cancelled:
                    completion(.failure(AppError.unknown))
                default:
                    completion(.failure(AppError.unknown))
                }
                return
            }
            if let data = data {
                let str = String(data: data, encoding: .utf8)
                print("Received data:\n\(str ?? "")")
                if let error = try? JSONDecoder().decode(ErrorModel.self, from: data) {
                    completion(.failure(AppError.serverError(error)))
                    return
                }
                
                guard let request = try? JSONDecoder().decode(RequestForHelp.self, from: data) else {
                    completion(.failure(.parsingError))
                    return
                }
                completion(.success(request))
                //   let lawyerToken = token.token
                // let lawyerStatus = token.status
                //   print("TOKEN: \(lawyerToken)")
                // print("STATUS: \(lawyerStatus)")
                // keychain.set(lawyerToken, forKey: "lawyerToken")
            }
        }
        task.resume()
    }
    
//    func sendRequestForHelp(adviceType: String) {
//        let url = URL(string: "https://api.6709.ru/v1/client/requests")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Accept")
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        let date = Date()
//        let identifier = UUID()
//        let model = RequestForHelp(requestId: identifier.uuidString, adviceType: adviceType, takenToWork: false, serviceProvided: false, closed: false, sentAt: "")
//        do {
//            let jsonData = try JSONEncoder().encode(model)
//            request.httpBody = jsonData
//        } catch let error{
//            debugPrint(error.localizedDescription)
//        }
//        let task = URLSession.shared.dataTask(with: request) {
//            (data, response, error) in
//            if let error = error {
//                print("ERROR: \(error)")
//            }
//            else if let data = data {
//                let str = String(data: data, encoding: .utf8)
//                print("Received data:\n\(str ?? "")")
//                
//            }
//            if let response = response {
//                guard let requestForHelp = try? JSONDecoder().decode(RequestForHelp.self, from: data!) else {return}
//                print("ADVICETYPE: \(requestForHelp.adviceType)")
//                print("DATE: \(requestForHelp.sentAt)")
//                print("ID: \(requestForHelp.requestId)")
//            }
//        }
//        task.resume()
//    }
    
    
    func regiterLawyer(model: Lawyer, completion: @escaping (Result< LawyerTokenStatus, AppError>) -> Void) { // 25.05.25
        let url = URL(string: "https://api.6709.ru/v1/user/lawyer/sign-up")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let jsonData = try JSONEncoder().encode(model)
            request.httpBody = jsonData
        } catch let error{
            switch error {
            case URLError.timedOut,
                URLError.notConnectedToInternet,
                URLError.networkConnectionLost,
                URLError.cannotFindHost:
                completion(.failure(AppError.internetConnectiomProblem))
            default:
                completion(.failure(AppError.unknown))
            }
           return
        }
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                switch error {
                case URLError.timedOut,
                    URLError.notConnectedToInternet,
                    URLError.networkConnectionLost,
                    URLError.cannotFindHost:
                    completion(.failure(AppError.internetConnectiomProblem))
                case URLError.cancelled:
                    completion(.failure(AppError.unknown))
                default:
                    completion(.failure(AppError.unknown))
                }
                return
            }
             if let data = data {
                 if let error = try? JSONDecoder().decode(ErrorModel.self, from: data) {
                     completion(.failure(AppError.serverError(error)))
                     return
                 }
                 guard let token = try? JSONDecoder().decode(LawyerTokenStatus.self, from: data) else {
                     completion(.failure(.parsingError))
                     return
                 }
                 completion(.success(token))
             }
        }
        task.resume()
    }

    func chekVerificationOfLawyer(model: LawyerInfo, completion: @escaping(Result<LawyerToken, AppError>) -> Void) {
        let url = URL(string: "https://api.6709.ru/v1/user/sign-in")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let jsonData = try JSONEncoder().encode(model)
            request.httpBody = jsonData
        } catch let error{
            switch error {
            case URLError.timedOut,
                URLError.notConnectedToInternet,
                URLError.networkConnectionLost,
                URLError.cannotFindHost:
                completion(.failure(AppError.internetConnectiomProblem))
            default:
                completion(.failure(AppError.unknown))
            }
           return
        }
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                switch error {
                case URLError.timedOut,
                    URLError.notConnectedToInternet,
                    URLError.networkConnectionLost,
                    URLError.cannotFindHost:
                    completion(.failure(AppError.internetConnectiomProblem))
                case URLError.cancelled:
                    completion(.failure(AppError.unknown))
                default:
                    completion(.failure(AppError.unknown))
                }
                return
            }
            if let data = data {
                if let error = try? JSONDecoder().decode(ErrorModel.self, from: data) {
                    completion(.failure(AppError.serverError(error)))
                    return
                }
            
            guard let token = try? JSONDecoder().decode(LawyerToken.self, from: data) else {
                     completion(.failure(.parsingError))
                     return
                 }
                 completion(.success(token))
             }
        }
        task.resume()
    }
    
//    func registerNewLawyer (Name: String, Patronymic: String, Surname: String, PhoneNumber: String, Password: String) {
//        let keychain = KeychainSwift()
//        let url = URL(string: "https://api.6709.ru/v1/user/lawyer/sign-up")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Accept")
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        let newData = Lawyer(name: Name, patronymic: Patronymic, surname: Surname, city: "", phone: PhoneNumber, password: Password)
//        do {
//            let jsonData = try JSONEncoder().encode(newData)
//            request.httpBody = jsonData
//        } catch let error{
//            debugPrint(error.localizedDescription)
//        }
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let error = error {
//                print("ERROR: \(error)")
//            }
//            else if let data = data {
//                let str = String(data: data, encoding: .utf8)
//                print("Received data:\n\(str ?? "")")
//            }
//            if let response = response {
//                guard let token = try? JSONDecoder().decode(LawyerToken.self, from: data!) else { return }
//            }
//        }
//        task.resume()
//        keychain.set("registeredLawyer", forKey: "roleLawyer")
//        keychain.set(Name, forKey: "lawyerName")
//        keychain.set(Patronymic, forKey: "lawyerPatronymic")
//        keychain.set(Surname, forKey: "lawyerSurname")
//        keychain.set(PhoneNumber, forKey: "lawyerPhoneNumber")
//        keychain.set(Password, forKey: "lawyerPassword")
//    }
   
    func deleteLawyer(token: String){
        let url = URL(string: "https://api.6709.ru/v1/lawyer")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        print("TONEN ACCEPTED  \(token)")
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            guard error == nil else {
                print("Error: error calling DELETE")
                print(error!)
                return
            }
            guard let data = data  else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else { 
                print("Error: HTTP request failed")
                print("TOKEN NOT DELETED: \(token)")
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

            } catch {
                return
            }
        }
        task.resume()

    }
    
    func fetchAllResponces() {
        let url = URL(string: "https://api.6709.ru/v1/client/requests")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { ( data, response, error) in
            do {
                let object = try? JSONDecoder().decode(RequestForHelp.self, from: data!)
                
            } catch let error {
              //  completion(.failure(AppError.parsingError))
               print("FAILED to DECODE", error)
            }
            if let response = response {
                          guard let requests = try? JSONDecoder().decode(RequestForHelp.self, from: data!) else {
                              print("NO DATA")
                              return}
           //                print("ADVICETYPE: \(temporaryInformation.adviceType)")
           //                print("DATE: \(temporaryInformation.requestId)")
           //                print("ID: \(temporaryInformation.requestId)")
                print(requests)
                print("++++++++++++")
                print(requests.adviceType , requests.requestId, requests.sentAt)
                print("++++++++++++")

//                }
            }
        }
        task.resume()
    }
    
    
//    func checkIfLawyerIsVerificated() {
//        let keychain = KeychainSwift()
//       let login = keychain.get("lawyerPhoneNumber")
//        let password = keychain.get("lawyerPassword")
//        let url = URL(string: "https://api.6709.ru/v1/user/sign-in")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Accept")
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        let newData = LawyerInfo(login: login!, password: password!, token: "", role: "")
//        do {
//            let jsonData = try JSONEncoder().encode(newData)
//            request.httpBody = jsonData
//        } catch let error{
//            debugPrint(error.localizedDescription)
//        }
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let error = error {
//                print("ERROR: \(error)")
//            }
//            else if let data = data {
//                let str = String(data: data, encoding: .utf8)
//                print("Received data:\n\(str ?? "")")
//            }
//            if let response = response {
//                guard let token = try? JSONDecoder().decode(LawyerToken.self, from: data!) else { return }
//                let lawyerToken = token.token
//                    keychain.set("varificatedLawyer", forKey: "roleLawyer")
//                    keychain.set(lawyerToken, forKey: "lawyerToken")
//                    if lawyerToken != "" {
//                       DispatchQueue.main.async {
//                       self.isLawyerAlreadyVerificated = true
//                   }
//                }
//            }
//        }
//        task.resume()
//    }
}
