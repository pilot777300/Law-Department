

import SwiftUI
import KeychainSwift
import FirebaseMessaging


struct ListOfChats: View {
    @StateObject var model = LawyerChatViewModel()

    var body: some View {
        NavigationStack {
            
           Text("Чаты с клиентами")
                .modifier(TxtModifierForOrders())
            Spacer()
            List(model.listOfChats, id: \.self) { item in
                ZStack(alignment: .leading){
                        NavigationLink {
                            LawyerChatScreen()
                        } label: {
                          //  RowOfChat(userName: item.fromUserName, text: item.text, time: item.sentAt)
                           // ChatMessageRow(message: "NEED HELP", isIncoming: true, sentAt: "13.01", isMessageRead: false)
                       }
                    .opacity(0)
                    let formattedDate = Date().formatDateForChat(dateFromServer: model.usersAndMessage.last!.sentAt)
                    RowOfChat(userName: item.userName, text: item.lastMessage, time: formattedDate)
                }

                
            }
            
            .lineLimit(1)
            .scrollContentBackground(.hidden)
            .background(Color.white)
        }
        .onAppear{
            model.fetchMessages()
            
            let now = Date.now
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
           //  dateFormatter.dateFormat = "HH : mm"

            let formattedDate = dateFormatter.string(from: Date())
            let nowformatted = dateFormatter.string(from: now)
           // let timeformatter = dateFormatter.string(from: Date())

            print("Formatted date: \(formattedDate)")
            print("NOW =", nowformatted)
            print("Formatted-", formattedDate)
          //  print("TimeFrmatted-", timeformatter)


        }

    }
}


#Preview {
    ListOfChats()
}
