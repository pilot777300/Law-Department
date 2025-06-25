//
//import SwiftUI
//import iPhoneNumberField
//
//
//struct UserAutorizationScreen: View {
//    
//    @State private var userName: String = ""
//    @State private var userPhoneNumber: String = ""
//    @State var isEditing: Bool = false
//   @State var isVerificationScreenTapped = false
//    private let sender = NetworkManager()
//    
//    var body: some View {
//        ZStack {
//            Color(UIColor.systemGray6)
//                .ignoresSafeArea()
//            VStack(alignment: .center, spacing:10) {
//                Image("appLabel")
//                    .position(x:190, y: 50)
//                    .padding(5)
//                
//                Text("Необходимо авторизоваться")
//                    .position(x: 190,y:-120)
//                    .font(.title3)
//                    .bold()
//                    .padding(5)
//                Text("Авторизация необходима чтобы адвокат мог с вами связаться по номеру телефона")
//                    .position(x: 190,y:-320)
//                    .font(.footnote)
//                    .padding(5)
//            }
//            Spacer()
//            
//            VStack(alignment: .center, spacing: 5) {
//                   TextField(
//                       "Имя",text: $userName)
//                   .position(x: 190,y:-70)
//                   .disableAutocorrection(true)
//                   .frame(height: 5)
//                   .font(.footnote)
//                   .textFieldStyle(RoundedBorderTextFieldStyle())
//                   .position(x: 190, y: 350)
//                    .padding(5)
//                
//                    
//                
//                iPhoneNumberField("(000) 000-0000", text: $userPhoneNumber, isEditing: $isEditing)
//                          .flagHidden(false)
//                          .flagSelectable(true)
//                          .font(UIFont(size: 14, weight: .light, design: .monospaced))
//                          .maximumDigits(11)
//                          .foregroundColor(Color.black)
//                          .clearButtonMode(.whileEditing)
//                          .onClear { _ in isEditing.toggle() }
//                          .accentColor(Color.blue)
//                          .padding()
//                          .background(Color.white)
//                          .cornerRadius(10)
//                          .shadow(color: isEditing ? .blue : .white, radius: 10)
//                          .position(x: 190, y: -40)
//                          .padding(3)
//                
//                
//
//                
//               }
//               .textFieldStyle(.roundedBorder)
//            
//            NavigationLink("", destination: OtpFormFieldView(), isActive: $isVerificationScreenTapped)
//            
//                Image("AutorizeButton")
//                    .position(x:190, y: 430)
//                    .onTapGesture {
//                       // print("TAPPED")
//                        isVerificationScreenTapped.toggle()
//                        sender.sendSms(ApiURL: "https://api.6709.ru/v1/user/client/sign-up", Name: userName, City: "", Phone: userPhoneNumber)
//                    }
//        }
//    }
//}
//
//#Preview {
//    UserAutorizationScreen()
//}
