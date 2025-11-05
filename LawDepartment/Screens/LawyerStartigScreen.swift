

import SwiftUI
import KeychainSwift

struct LawyerStartigScreen: View {

  //  @StateObject var subscribe: SubscribingToTopics = .init()
    
    
    var body: some View {
        TabView {
            NavigationStack {
            OrdersScreen()
                    }
//            .onAppear {
//                subscribe.subscribeToTopic()
//                print("LAWYER REGISTERED", isLawyerRegistered)
//            }
                    .tabItem {
                        Image(systemName: "folder.fill.badge.plus")
                        Text("Заявки")
                    }
                NavigationStack {
                    ListOfChats()
                        }
                        .tabItem {
                            Image(systemName: "message.fill")
                            Text("Чат")
                        }
                NavigationStack {
                    LawyerSettingsScreen()
                        }
                        .tabItem {
                        Image(systemName: "person.fill")
                        Text("Профиль")
            }
        }
//        .onAppear {
//            subscribe.subscribeToTopic()
//        }
    }
    
}

#Preview {
   // LawyerStartigScreen()
}
