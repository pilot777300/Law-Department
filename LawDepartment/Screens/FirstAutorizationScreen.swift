
import SwiftUI
import iPhoneNumberField

struct FirstAutorizationScreen: View {
    @Environment(\.dismiss) var dismiss
    @State var isShowSmsScr = false
    @State private var userName: String = ""
    @State private var city: String = ""
    @State private var userPhoneNumber: String = ""
    @State var isEditing: Bool = false
    private let sender = NetworkManager()
    
    var body: some View {
      NavigationStack {
            ZStack {
                Color(UIColor.systemGray6)
                    .ignoresSafeArea()
                VStack(alignment: .center, spacing: 10){
                    Image("appLabel")
                        .padding(5)
                    Text("Необходимо авторизоваться")
                        .font(.title3)
                        .bold()
                        .padding(5)
                    Text("Авторизация необходима чтобы адвокат мог с вами связаться")
                        .font(.footnote)
                        .padding(5)
                    TextField(
                        "Ваше имя",text: $userName)
                    .disableAutocorrection(true)
                    .frame(height: 5)
                    .font(.footnote)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                     .padding(15)
                    
                    TextField("Из какого вы орода", text: $city)
                        .disableAutocorrection(true)
                        .frame(height: 5)
                        .font(.footnote)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                         .padding(15)
                    
                    iPhoneNumberField("(000) 000-0000", text: $userPhoneNumber, isEditing: $isEditing)
                              .flagHidden(false)
                              .flagSelectable(true)
                              .font(UIFont(size: 14, weight: .light, design: .monospaced))
                              .maximumDigits(11)
                              .foregroundColor(Color.black)
                              .clearButtonMode(.whileEditing)
                              .onClear { _ in isEditing.toggle() }
                              .accentColor(Color.blue)
                              .padding()
                              .background(Color.white)
                              .cornerRadius(10)
                              .shadow(color: isEditing ? .blue : .white, radius: 10)
                              .padding(15)
                    
        NavigationLink(destination: SmsVerifNewScreen()
                        .onAppear {
//                sender.sendSms(ApiURL: "https://api.6709.ru/v1/user/client/sign-up", Name: userName, City: "", Phone: userPhoneNumber)
                            print("TAPPED")
                           })
                    {
                        Image("AutorizeButton")
                    }

                       
                //    Image("AutorizeButton")
                   //         .padding()
                             ////   .onTapGesture {
                               //     print("TAPЗЗЗЗЗЗPED")
                               //    sender.sendSms(ApiURL: "https://api.6709.ru/v1/user/client/sign-up", Name: userName, City: "", Phone: userPhoneNumber)
                       // isVerificationScreenTapped.toggle()
                                    
              //              }
              //     }
                    Spacer()
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
    FirstAutorizationScreen()
}
