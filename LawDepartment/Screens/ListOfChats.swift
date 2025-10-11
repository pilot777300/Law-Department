

import SwiftUI
import KeychainSwift
import FirebaseMessaging


struct ListOfChats: View {
    @StateObject var notificationManager = NotificationManager()

    var body: some View {
        NavigationStack {
            
           Text("Чаты с клиентами")
            Spacer()
            List(0..<5) { item in
                ZStack(alignment: .leading){
                    NavigationLink {
                        ChatScreen(isUserWriting: .constant(true))
                    } label: {
                        RowOfChat(dataForChat: Message(id: UUID.init(), user: User(name: "Jane", phoneNumber: ""), content: "Срочно нужно проконсультировать по вопросу, ведь "))
                        
                }
                    .opacity(0)
                   RowOfChat(dataForChat: Message(id: UUID.init(), user: User(name: "Jane", phoneNumber: ""), content: "Срочно нужно проконсультировать по вопросу, ведь "))
                }

                
            }
            
            .lineLimit(1)
            .scrollContentBackground(.hidden)
            .background(Color.white)
        }
        .onAppear{
            Task{
                               await notificationManager.request()
                           }
//            Messaging.messaging().subscribe(toTopic: "newOrder") { error in
//                print("Subscribed to  topic", error?.localizedDescription ?? "NO ERROR")
//            }
        }
        .disabled(notificationManager.hasPermission)
        .task {
                        await notificationManager.getAuthStatus()
            
                    }
    }
}


#Preview {
    ListOfChats()
}
