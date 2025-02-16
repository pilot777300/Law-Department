
import SwiftUI

struct RequestHasSentScreen: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        
        ZStack {
            Image("backgroundVector")
            VStack(alignment: .center, spacing: 5) {
                Text("Ваш запрос отправлен!")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.title)
                    .padding(10)
                Text("Адвокат свяжется с вами в течение 5 минут")
                    .fontWeight(.semibold)
                    .font(.title3)
                    .padding(10)
                
                Text("Ожидайте звонка на номер, который вы указали при регистрации в приложении")
                    .font(.callout)
                    .padding()
                
                Image("molotok")
                    .padding(10)
                
                Image("waitingButton")
                    .padding(20)
                    .onTapGesture {
                        print("Tapppped")
                        dismiss()
                        
                    }
            }
            Spacer()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(10)
        }
    }
}

#Preview {
    RequestHasSentScreen()
}
