

import SwiftUI

struct LawyerMainScreen: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.systemGray6)
                    .ignoresSafeArea()
                VStack (alignment: .center, spacing: 30){
                Text("Мои заявки")
                    .padding(.top, -350)
                    
                HStack(spacing: 50) {
                    Text("Новые заявки")
                        .font(.caption)
                        .underline()
                    Text("Завершенные заявки")
                        .font(.caption)
                }
                .padding(.top, -340)
            }

                NavigationSplitView {  //----
                    List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                        
                        NavigationLink {
                            OrderDetailScreen()
                        } label: {
                            VStack (alignment: .leading){
                                Text("№ заявки:")
                                    .font(.caption)
                                
                                
                                HStack {
                                    
                                    Text("Дата: 18.02.2024")
                                        .font(.caption)
                                    
                                    Text("Время: 18.56")
                                        .font(.caption)
                                    
                                }
                                Text("Имя пользователя: Виктор")
                                    .font(.caption)
                                
                                Text("Телефон пользователя: 8(999)9999993")
                                    .font(.caption)
                                
                                Text("Нужна помощь по делу: Уголовное")
                                    .font(.caption)
                                
                              }
                        }
                    }
                    
                    .padding(.top, 70)
                } detail: {Text("")} //---
            
            }
        }
    }
}

#Preview {
    LawyerMainScreen()
}
