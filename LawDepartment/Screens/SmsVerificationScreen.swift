import SwiftUI

struct OtpFormFieldView: View {
    @Environment(\.dismiss) var dismiss
    @State var isShowChoiseScreen = false
    private let confirmator = NetworkManager()
   @State var codeFromSms: String = ""
    enum FocusPin {
        case  pinOne, pinTwo, pinThree, pinFour, pinFive, pinSix
                    }
    @FocusState private var pinFocusState : FocusPin?
    @State var pinOne: String = ""
    @State var pinTwo: String = ""
    @State var pinThree: String = ""
    @State var pinFour: String = ""
    @State var pinFive: String = ""
    @State var pinSix: String = ""
    @State private var showAlert = false
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
                    
                    HStack(spacing:15, content: {
                        TextField("", text: $pinOne)
                            .modifier(OtpModifer(pin:$pinOne))
                            .onChange(of:pinOne){newVal in
                                if (newVal.count == 1) {
                                    pinFocusState = .pinTwo
                                }
                            }
                            .focused($pinFocusState, equals: .pinOne)
                            .textContentType(.oneTimeCode)
                        
                        TextField("", text:  $pinTwo)
                            .modifier(OtpModifer(pin:$pinTwo))
                            .onChange(of:pinTwo){newVal in
                                if (newVal.count == 1) {
                                    pinFocusState = .pinThree
                                }
                            }
                            .focused($pinFocusState, equals: .pinTwo)
                            .textContentType(.oneTimeCode)
                        
                        TextField("", text:$pinThree)
                            .modifier(OtpModifer(pin:$pinThree))
                            .onChange(of:pinThree){newVal in
                                if (newVal.count == 1) {
                                    pinFocusState = .pinFour
                                }
                            }
                            .focused($pinFocusState, equals: .pinThree)
                            .textContentType(.oneTimeCode)
                        
                        TextField("", text:$pinFour)
                            .modifier(OtpModifer(pin:$pinFour))
                            .onChange(of:pinFour){newVal in
                                if (newVal.count == 1) {
                                    pinFocusState = .pinFive
                                }
                            }
                            .focused($pinFocusState, equals: .pinFour)
                            .textContentType(.oneTimeCode)
                        
                        TextField("", text: $pinFive)
                            .modifier(OtpModifer(pin:$pinFive))
                            .onChange(of:pinFive){newVal in
                                if (newVal.count == 1) {
                                    pinFocusState = .pinSix
                                }
                            }
                            .focused($pinFocusState, equals: .pinFive)
                            .textContentType(.oneTimeCode)
                        
                        TextField("", text: $pinSix)
                            .modifier(OtpModifer(pin:$pinSix))
                            .focused($pinFocusState, equals: .pinSix)
                            .textContentType(.oneTimeCode)
                        
                    })
                    .padding(.vertical)
                    Button ("Подтвердить") {
                        if pinOne == "" || pinTwo  == "" || pinThree == ""  || pinFour == "" || pinFive == "" || pinSix == "" {
                            showAlert = true
                        } else {
                            codeFromSms = pinOne + pinTwo + pinThree + pinFour + pinFive + pinSix
                            confirmator.confirmCode(VerificationCode: codeFromSms)
                            isShowChoiseScreen = true
                            }
                        }
                    .navigationDestination(isPresented: $isShowChoiseScreen) {
                        ChoiseScreen()
                            }
                    .alert(isPresented: $showAlert) {
                    Alert(title: Text("Не все поля заполнены!"),
                    message: nil)
                       }
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(15)
                    .background(Color.blue)
                    .cornerRadius(15)
                    .padding()
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
    OtpFormFieldView()
}
