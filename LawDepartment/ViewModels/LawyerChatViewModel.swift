
import Foundation
import SwiftUI
import KeychainSwift

enum LawyerChatScreenState {
    case `default`
    case loading
    case success
    case failure
}

extension Date {
    func formatDateForChat(dateFromServer:String) -> String {
//       var tempData = ""
        let now = Date.now
//
//        let nowChecker = DateFormatter()
//        nowChecker.dateFormat = "yyyy-MM-dd"
        
        
       //  dateFormatter.dateFormat = "HH : mm"
        
        let timeFormatter = DateFormatter()
        let isoTome = dateFromServer
        let form = ISO8601DateFormatter()
       // let time = form.date(from: isoDate)
        
        let dateAndTimeFormatter = DateFormatter()
        let isoDateAndTime = dateFromServer
        let fullFormatter = ISO8601DateFormatter()
        let fullDateAndTime = fullFormatter.date(from: isoDateAndTime)
        
        let dateFormatter = DateFormatter()
        let isoDate = dateFromServer
        let formatter = ISO8601DateFormatter()
        let date = formatter.date(from: isoDate)
         //  dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd")    //("MMM EEEE HH:mm:ss")
      //  dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd")
        dateFormatter.dateFormat = "yyyy-MM-dd"
       
        
        
        let time = form.date(from: isoDate)
        timeFormatter.dateFormat = "HH:mm"
        
        dateAndTimeFormatter.dateFormat = "MMM EEEE HH:mm:ss"

        dateAndTimeFormatter.dateStyle = .medium
      //  dateFormatter.timeStyle = .short
            dateAndTimeFormatter.locale = Locale(identifier: "ru")
        let fullDateAndTimeString = dateAndTimeFormatter.string(from: fullDateAndTime!)
        let formattedTime = timeFormatter.string(from: time!)
           let formattedDate = dateFormatter.string(from: date!)
       
        let firstDate = formatter.date(from: "\(now)")
        let secondDate = formatter.date(from: "\(date!)")

        if firstDate?.compare(secondDate!) == .orderedSame {
            return formattedTime
        }
                  return formattedTime//fullDateAndTimeString//formattedDate
        }
}

@MainActor
final class LawyerChatViewModel: ObservableObject {
    
    @Published var screenState: LawyerChatScreenState = .default
    @Published var userName: String = "Username"
   // @Published var appLauncher: AppLauncher?
    @Published var typingMessage: String = ""
   // @Published var sendByMe: Bool = false
  //  @Published var messages = ["First Message"] // ?????
    @Published var dateAndTime: String = ""
    @Published var pageNumber = 0
    @Published var pageSize = 18
   // @Published var incomingMessagedg = [String]()
   // @Published var outgoingMessage = [String]()
  //  @Published var allChats = [MessageFromUser]()
  //  @Published var autorOfMessage: [String] = []
    @Published var listOfChats = [ListOfChatRow]()
    @Published var usersAndMessage =  [MessageFromUser]() //[UserAndMessage]()
    @Published var userId: Int = 0
    var error: AppError?
    let keychain = KeychainSwift()
    let network = NetworkManager()
    
//    init (usersAndMessage: UserAndMessage) {
//        self.usersAndMessage = usersAndMessage
//    }

    
    func sendMessage(text: String) {
        let token = keychain.get("lawyerToken") ?? ""
        let model = UserChatMessage(text: text)
        network.sendMessageFromLawyertoUser(token: token, userId: userId, model: model) { [weak self] result in
            Task { @MainActor in
                switch result {
                case .success(let message):
                   // self?.sendByMe = true
                  //  self!.messages.append(message.text)
                    self?.screenState = .success
                  //  print("MESSAGES AFTER APPEND === =", self!.messages)
                case .failure(let error):
                    self?.error = error
                    self?.screenState = .failure
                }
            }
        }
        
    }
    
    func fetchMessages() {
        let token = keychain.get("lawyerToken") ?? ""            
        network.fetchMessagesFromUser(token: token, pageNumber: self.pageNumber, pageSize: self.pageSize) { [weak self] result in
                Task { @MainActor in
                    switch result {
                    case .success(let message):
                        var localArray: [String] = []
                        var localArray2: [MessageFromUser] = []
                        var localArray3: [ListOfChatRow] = []
                      //  var localArrar4: [String] = []
                        let modelToListOfChats = ListOfChatRow(userName: message.first!.fromUserName, lastMessage: message.last!.text, timeStamp: message.last!.sentAt)

                        for i in message {
//                            self?.sendByMe = i.sendByMe
                            self!.userName = i.fromUserName
//                            self!.userId = i.fromUserId
//                            self!.dateAndTime = i.sentAt
                            let model = MessageFromUser(fromUserId: i.fromUserId,
                                                        fromUserName: i.fromUserName,
                                                        text: i.text,
                                                        sentAt: i.sentAt,
                                                        sendByMe: i.sendByMe)
                                                        
                          //  localArray.append(i.text)  // ?????
                           // self!.messages = localArray // ????
                            
                            localArray2.append(model)
                            self!.usersAndMessage = localArray2
                            print("MESS==", i.text)

                              }
                        localArray3.append(modelToListOfChats)
                        self!.listOfChats = localArray3
                        self?.screenState = .success
                    case .failure(let error):
                        self?.error = error
                        self?.screenState = .failure
                        print("ERROR FROM COMPL")
                    }
                    
                }
            }
        }
        
    }
    
//}
