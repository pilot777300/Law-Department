

import SwiftUI
import KeychainSwift

struct LawyerStartigScreen: View {

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
