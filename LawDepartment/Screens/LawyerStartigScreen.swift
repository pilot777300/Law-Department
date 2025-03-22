

import SwiftUI

struct LawyerStartigScreen: View {
    var body: some View {
        TabView {
                NavigationStack {
                    ListOfChats()
                        }
                        .tabItem {
                            Image(systemName: "message.fill")
                            Text("Чат")
                        }
                NavigationStack {
                OrdersScreen()
                        }
                        .tabItem {
                            Image(systemName: "folder.fill.badge.plus")
                            Text("Заявки")
                        }
                NavigationStack {
                    LawyerSettingsScreen(lawyer: Lawyer(name: "ANTON", patronymic: "Sergeevich", surname: "Kolsov", city: "", phone: ""))
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
