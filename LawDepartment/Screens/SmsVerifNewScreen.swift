

import SwiftUI


struct SmsVerifNewScreen: View {
    @Environment(\.dismiss) var dismiss
    @State var isShowChoiseScreen = false
    private let confirmator = NetworkManager()
    @State var codeFromSms: String = ""
    var body: some View {
        NavigationStack {
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
                   
                    Button("Подтвердить")
                    {
                        isShowChoiseScreen = true
                        confirmator.confirmCode(VerificationCode: codeFromSms)
                                }
                    .navigationDestination(isPresented: $isShowChoiseScreen) {
                        ChoiseScreen()
                            }
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.blue)
                    .clipShape(Capsule())
                .padding(20)
                    
                    
                   
//                    NavigationLink(destination: AuthorizedUserMainScreen()) {
//                        Button(action: {
//                            confirmator.confirmCode(VerificationCode: codeFromSms)
//                        }, label: {
//                            Spacer()
//                            Text("Подтвердить")
//                                .font(.system(.title3, design: .rounded))
//                                .fontWeight(.semibold)
//                                .foregroundColor(.white)
//                            Spacer()
//                        })
//                        .padding(15)
//                        .background(Color.blue)
//                        .clipShape(Capsule())
//                    .padding()
//                    }
                }
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button (action: {
                            dismiss()
                        }) {
                            Label("Back", systemImage: "chevron.left.circle")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SmsVerifNewScreen()
}
