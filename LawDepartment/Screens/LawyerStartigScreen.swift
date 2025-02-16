

import SwiftUI

struct LawyerStartigScreen: View {
    var body: some View {
        ZStack {
              Image("backgroundVector")
                .resizable()
                .aspectRatio(contentMode: .fit)
               .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            // }
            
            TabView {
                Text("Чат")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .tabItem {
                        Image(systemName: "message.fill")
                        Text("Чат")
                    }

                    OrdersScreen()
                    .tabItem {
                        Image(systemName: "folder.fill.badge.plus")
                        Text("Заявки")
                    }
                
                Text("Профиль")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Профиль")
                    }
                
                
            }
            Spacer()
        }
        .padding(5)
                    .foregroundColor(.primary)
                    .background(Color.primary
                                    .colorInvert()
                                    .opacity(0.75))
    }
      
}

#Preview {
    LawyerStartigScreen()
}
