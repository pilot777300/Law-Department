

import SwiftUI
import KeychainSwift
//import FirebaseMessaging


struct LawyerStartigScreen: View {
  //  @StateObject var notificationManager = NotificationManager()
  //  @StateObject var delegate: AppDelegate = .init()//OrderViewModel = .init()


    var body: some View {
        TabView {
            NavigationStack {
            OrdersScreen()
                    }
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
    }
}

#Preview {
    LawyerStartigScreen()
}
