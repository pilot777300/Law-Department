import SwiftUI

struct OtpFormFieldView: View {
   
    @Environment(\.dismiss) var dismiss
    @State private var showAlertEmtyForm = false
    @State private var showAlertRequestFailed = false
    @State private var isShowChoiseScreen = false
    @StateObject private var viewModel: ConfirmCodeViewModel = .init(service: UserRegistrationService())
   
    enum FocusPin {
        case  pinOne, pinTwo, pinThree, pinFour, pinFive, pinSix
    }
    
    @FocusState private var pinFocusState : FocusPin?
  //  @State private var showAlert = false
    var body: some View {
        NavigationStack {
            switch viewModel.screenState {
            case .default:
                content
            case .sucess:
                content
                    .onAppear{
                        isShowChoiseScreen = true
                    }
            case .loading:
                content
                    .overlay{
                        ProgressView()
                    }
            case .invalidForm:
                invalidForm
            case .error:
                errorView()
            }
        }
    }
    
    private func errorView() -> some View {
        let error = viewModel.error ?? .unknown
        let title = "Внимание!"
        var message = ""
        switch error {
        case .serverError(let error):
            message = error.error
        case .internetConnectiomProblem:
            break
        case .parsingError:
            break
        case .unknown:
            break
        }
        return content
            .onAppear{
                showAlertRequestFailed = true
            }
            .alert(isPresented: $showAlertRequestFailed) {
                Alert(title: Text(title),
                      message: Text(message))
            }
    }
    
    private var invalidForm: some View {
        content
            .onAppear{
                showAlertEmtyForm = true
            }
            .alert(isPresented: $showAlertEmtyForm) {
                Alert(title: Text("Поля не должны быть пустыми!"),
                      message: nil)
            }
    }
    
    
    var content: some View {
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
                    TextField("", text: $viewModel.pinOne)
                        .modifier(OtpModifer(pin:$viewModel.pinOne))
                        .onChange(of:viewModel.pinOne){newVal in
                            if (newVal.count == 1) {
                                pinFocusState = .pinTwo
                            }
                        }
                        .focused($pinFocusState, equals: .pinOne)
                        .textContentType(.oneTimeCode)
                    
                    TextField("", text:  $viewModel.pinTwo)
                        .modifier(OtpModifer(pin:$viewModel.pinTwo))
                        .onChange(of:viewModel.pinTwo){newVal in
                            if (newVal.count == 1) {
                                pinFocusState = .pinThree
                            }
                        }
                        .focused($pinFocusState, equals: .pinTwo)
                        .textContentType(.oneTimeCode)
                    
                    TextField("", text:$viewModel.pinThree)
                        .modifier(OtpModifer(pin:$viewModel.pinThree))
                        .onChange(of:viewModel.pinThree){newVal in
                            if (newVal.count == 1) {
                                pinFocusState = .pinFour
                            }
                        }
                        .focused($pinFocusState, equals: .pinThree)
                        .textContentType(.oneTimeCode)
                    
                    TextField("", text:$viewModel.pinFour)
                        .modifier(OtpModifer(pin:$viewModel.pinFour))
                        .onChange(of:viewModel.pinFour){newVal in
                            if (newVal.count == 1) {
                                pinFocusState = .pinFive
                            }
                        }
                        .focused($pinFocusState, equals: .pinFour)
                        .textContentType(.oneTimeCode)
                    
                    TextField("", text: $viewModel.pinFive)
                        .modifier(OtpModifer(pin:$viewModel.pinFive))
                        .onChange(of:viewModel.pinFive){newVal in
                            if (newVal.count == 1) {
                                pinFocusState = .pinSix
                            }
                        }
                        .focused($pinFocusState, equals: .pinFive)
                        .textContentType(.oneTimeCode)
                    
                    TextField("", text: $viewModel.pinSix)
                        .modifier(OtpModifer(pin:$viewModel.pinSix))
                        .focused($pinFocusState, equals: .pinSix)
                        .textContentType(.oneTimeCode)
                    
                })
                .padding(.vertical)
                Button ("Подтвердить") {
                    viewModel.confirmSmsCode()
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
    #Preview {
        OtpFormFieldView()
    }
    

