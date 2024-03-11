

import SwiftUI
    
struct ChoiseScreen: View {
    
    @State var isChoiseBtnPressed = false
   // @Binding var activateRootLink: Bool
    
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

                        }
                }
                .padding(-60)
                HStack(spacing: -70) {
                    Image("forBusiness")
                    Image("forFamily")
                }
              //  .padding(-20)
                HStack(spacing: -70) {
                    Image("forDTP")
                    Image("forAnother")
                }
                .padding(-60)
            }
            .sheet(isPresented: $isChoiseBtnPressed) {
                RequestHasSentScreen()
            }
            
        }
    }
    
}


#Preview {
    ChoiseScreen()
}
