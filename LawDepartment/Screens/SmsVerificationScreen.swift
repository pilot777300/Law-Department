import SwiftUI
import Combine

struct OtpFormFieldView: View {
    
    enum FocusPin {
        case  pinOne, pinTwo, pinThree, pinFour
    }

    @FocusState private var pinFocusState : FocusPin?
    @State var pinOne: String = ""
    @State var pinTwo: String = ""
    @State var pinThree: String = ""
    @State var pinFour: String = ""

    var body: some View {
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

                        TextField("", text:  $pinTwo)
                            .modifier(OtpModifer(pin:$pinTwo))
                            .onChange(of:pinTwo){newVal in
                                if (newVal.count == 1) {
                                    pinFocusState = .pinThree
                                }
                            }
                            .focused($pinFocusState, equals: .pinTwo)


                        TextField("", text:$pinThree)
                            .modifier(OtpModifer(pin:$pinThree))
                            .onChange(of:pinThree){newVal in
                                if (newVal.count == 1) {
                                    pinFocusState = .pinFour
                                }
                            }
                            .focused($pinFocusState, equals: .pinThree)


                        TextField("", text:$pinFour)
                            .modifier(OtpModifer(pin:$pinFour))
                            .focused($pinFocusState, equals: .pinFour)


                    })
                    .padding(.vertical)


                    Button(action: {}, label: {
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


#Preview {
    OtpFormFieldView()
}
