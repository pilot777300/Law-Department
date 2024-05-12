

import SwiftUI
    
struct ChoiseScreen: View {
    
    @State var isChoiseBtnPressed = false
   private  let checker = NetworkManager()
    
    
    var body: some View {
        
        ZStack {
            Image("backgroundVector")
                .ignoresSafeArea()
            VStack(alignment: .center, spacing: -5) {
                Text("По какому делу требуется помощь?")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(-5)
                Text(" Мы  направим ваш запрос к адвокату в соответствии с его специализацией")
                    .font(.caption)
                    .padding(55)
            
                HStack(spacing: -70) {
                    Image("forCivil")
                        .onTapGesture {
                            print("Гражданское нажато")
                            
                            isChoiseBtnPressed.toggle()
                            
                        }
                    Image("forCriminal")
                        .onTapGesture {
                            print("Уголовное нажато")
                            isChoiseBtnPressed.toggle()

                        }
                }
                .padding(-60)
                HStack(spacing: -70) {
                    
                    Image("forBusiness")
                        .onTapGesture {
                            print("Для бизнеса нажато")
                            isChoiseBtnPressed.toggle()
                        }
                    
                    Image("forFamily")
                        .onTapGesture {
                            print("Семейное нажато")
                            isChoiseBtnPressed.toggle()
                        }
                }
              //  .padding(-20)
                HStack(spacing: -70) {
                    Image("forDTP")
                        .onTapGesture {
                            print("По ДТП нажато")
                            isChoiseBtnPressed.toggle()
                        }
                   
                    Image("forAnother")
                        .onTapGesture {
                            print("Уголовное нажато")
                            isChoiseBtnPressed.toggle()

                        }
                }
                .padding(-60)
            }
            .sheet(isPresented: $isChoiseBtnPressed) {
                if userName != "Пользователь" {
                    RequestHasSentScreen()
                } else {
                    FirstAutorizationScreen()
                }
            }
        }
    }
}


#Preview {
    ChoiseScreen()
}
