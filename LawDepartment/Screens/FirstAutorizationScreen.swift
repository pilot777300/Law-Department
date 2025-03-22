
import SwiftUI
import iPhoneNumberField
import CustomTextField

struct FirstAutorizationScreen: View {
    @Environment(\.dismiss) var dismiss
    @State var isShowSmsScr = false
    @State private var userName: String = ""
    @State private var userCity: String = ""
    @State private var userPhoneNumber: String = ""
    @State var isEditing: Bool = false
    private let sender = NetworkManager()
    @State private var showAlert = false
    @State private var showConfirmSmsScreen = false
    var body: some View {
      NavigationStack {
            ZStack {
                Color(UIColor.systemGray6)
                    .ignoresSafeArea()
                VStack(alignment: .center, spacing: 10){
                    Image("appLabel")
                        .padding(-20)
                    Text("Необходимо авторизоваться")
                        .font(.title3)
                        .bold()
                        .padding(15)
                    Text("Авторизация необходима чтобы адвокат мог с вами связаться. Все поля обязательны для заполнения.")
                        .font(.footnote)
                        .padding(5)
                    
                    CustomTF(text: $userName, placeholder: "Имя", ImageTF: Image(systemName: "person"), isPassword: false, StylesType: .Style1, KeyboardType: .default, color: nil)
                        .padding(5)
                    
                    CustomTF(text: $userCity, placeholder: "Город", ImageTF: Image(systemName: "house"), isPassword: false, StylesType: .Style1, KeyboardType: .default, color: nil)
                        .padding(5)

                    iPhoneNumberField("(800) 000-0000", text: $userPhoneNumber, isEditing: $isEditing)
                              .flagHidden(false)
                              .font(UIFont(size: 15, weight: .semibold, design: .monospaced))
                              .maximumDigits(11)
                              .clearButtonMode(.whileEditing)
                              .onClear { _ in isEditing.toggle() }
                              .prefixHidden(false)
                              .padding()
                              .background(Color.init(uiColor: .systemGray6))
                              .overlay(
                                     RoundedRectangle(cornerRadius: 18)
                                         .stroke(Color.black, lineWidth: 1)
                                 )
                              .keyboardType(.numberPad)
                              .padding(5)
                    
                  
                    Button(action: {
                        if userName == "" || userCity == "" || userPhoneNumber == "" {
                            showAlert = true
                        } else {
                 //   sender.sendSms(ApiURL: "https://api.6709.ru/v1/user/client/sign-up", Name: userName, City: "", Phone: userPhoneNumber)
                            showConfirmSmsScreen = true
                        }                   
                        }) {
                            Image("AutorizeButton")}
                        .navigationDestination(isPresented: $showConfirmSmsScreen) {
                            OtpFormFieldView()
                                }
                        .alert(isPresented: $showAlert) {
                        Alert(title: Text("Все поля должны быть заполнены!"),
                        message: nil)
                           }
                        .padding(20)
                    Spacer()
            }
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button (action: {
                            dismiss()
                        }) {
                            Label("Back", systemImage: "chevron.left")
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
