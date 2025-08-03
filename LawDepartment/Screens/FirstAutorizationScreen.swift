
import SwiftUI
import iPhoneNumberField
import CustomTextField

struct FirstAutorizationScreen: View {
    @Environment(\.dismiss) var dismiss
    @StateObject  var viewModel: UserRegistrationViewModel = .init()
    @State var isEditing: Bool = false
    @State private var showAlertEmptyFields = false
    @State private var showAlertRequestFailed = false
    @State private var showConfirmSmsScreen = false
    
    var body: some View {
      NavigationStack {
          switch viewModel.screenState {
          case .default:
              content
          case .loadind:
              content
                  .overlay {
                      ProgressView()
                  }
          case .invalidForm:
              invalidFormView
          case .error:
              errorView()
          case .success:
              content
                  .onAppear{
                      showConfirmSmsScreen = true
                  }
            }
       }
        
    }
    
    private var invalidFormView: some View {
        content
            .onAppear {
                showAlertEmptyFields = true
            }
            .alert(isPresented: $showAlertEmptyFields) {
                Alert(title: Text("Все поля должны быть заполнены!"),
                      message: nil)
            }
    }
    
    private func errorView() -> some View {
        let error = viewModel.error ?? .unknown
        let title = "Внимание"
        var message = " "
        switch error {
        case .internetConnectiomProblem:
            break
        case .parsingError:
            break
        case .serverError(let error):
            message = error.error
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
    
    private var content: some View {
        NavigationStack {
              ZStack {
                  Color(UIColor.white)
                      .ignoresSafeArea()
                  VStack(alignment: .center, spacing: 10){
                      Image("appLabel")
                      Text("Необходимо авторизоваться")
                          .font(.title3)
                          .bold()
                          .padding(15)
                      Text("Авторизация необходима чтобы адвокат мог с вами связаться по телефону. Все поля обязательны для заполнения.")
                          .font(.footnote)
                          .padding(5)
                      
                      CustomTF(text: $viewModel.userName, placeholder: "Имя", ImageTF: Image(systemName: "person"), isPassword: false, StylesType: .Style1, KeyboardType: .default, color: nil)
                          .padding(5)
                      
                      CustomTF(text: $viewModel.userCity, placeholder: "Город", ImageTF: Image(systemName: "house"), isPassword: false, StylesType: .Style1, KeyboardType: .default, color: nil)
                          .padding(5)

                      iPhoneNumberField("(800) 000-0000", text: $viewModel.userPhoneNumber, isEditing: $isEditing)
                                .flagHidden(false)
                                .font(UIFont(size: 15, weight: .semibold, design: .monospaced))
                                .maximumDigits(11)
                                .clearButtonMode(.whileEditing)
                                .onClear { _ in isEditing.toggle() }
                                .prefixHidden(false)
                                .padding()
                                .background(Color.init(uiColor: .white))
                                .overlay(
                                       RoundedRectangle(cornerRadius: 18)
                                           .stroke(Color.black, lineWidth: 1)
                                   )
                                .keyboardType(.numberPad)
                                .padding(5)
                      
                      Button(action: {
                          viewModel.sendSms()
                          })
                      {
                          Image("AutorizeButton")
                      }
                      
                          .navigationDestination(isPresented: $showConfirmSmsScreen) {
                              OtpFormFieldView()
                                  }
                      
                          .alert(isPresented: $showAlertEmptyFields) {
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
    FirstAutorizationScreen(viewModel: UserRegistrationViewModel())
}
