

import SwiftUI


struct SmsVerifNewScreen: View {
    @Environment(\.dismiss) var dismiss
    private let confirmator = NetworkManager()
    @State var codeFromSms: String = ""
    var body: some View {
        NavigationView {
            ZStack {
                Color.init(uiColor: .systemGray6)
                    .ignoresSafeArea()
                VStack {
                    Text("Введите код из смс")
                        .font(.title2)
                        .fontWeight(.semibold)


                    Text("Мы отправили код на ваш номер телефона")
                        .font(.caption)
                        .fontWeight(.thin)
                        .padding(.top)
                    
                    TextField("Введите код из смс", text: $codeFromSms)
                        .disableAutocorrection(true)
                        .frame(width: 150)
                        .font(.footnote)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width:150)
                         .padding(10)
                         .textContentType(.oneTimeCode)
                         .multilineTextAlignment(.center)
                    
                    Button(action: {
                        confirmator.confirmCode(VerificationCode: codeFromSms)
                        dismiss()
                      //  AuthorizedUserMainScreen()
                    }, label: {
                        Spacer()
                        Text("Подтвердить")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        Spacer()
                    })
                    .padding(15)
                    .background(Color.blue)
                    .clipShape(Capsule())
                    .padding()
                }
            }
        }
    }
}

#Preview {
    SmsVerifNewScreen()
}
