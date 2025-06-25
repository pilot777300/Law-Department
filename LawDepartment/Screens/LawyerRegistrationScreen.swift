

import SwiftUI
import CustomTextField

struct LawyerRegistrationScreen: View {
    
    @StateObject private var viewModel: LawyerRegistrationViewModel = .init(service: LawyerRegistrationImplementation())

    @State private var showAlertEmptyFields = false
    @State private var showOnboardigForLawyer = false
    @State private var showAlertRequestFailed = false
    @State private var showAlertSuccessRegistration = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            switch viewModel.screenState {
            case .default:
               content
            case .loading:
                  content
                    .overlay {
                        ProgressView()
                    }
            case .success:
                content
                    .onAppear{
                        showOnboardigForLawyer = true
                        showAlertSuccessRegistration = true
                    }
                    .alert(isPresented: $showAlertSuccessRegistration){
                        Alert(title: Text("Данные отправлены для верификации"),
                              message: nil)
                    }
            case .failure:
                errorView()
                
            case .invalidForm:
                invalidFormView
            }
        }
    }
    
    private func errorView() -> some View {
        let error = viewModel.error ?? .unknown
        let title = "Ошибка выполнения запроса"
        var message = "Повторите попытку позже"
        switch error {
        case .unknown:
            break
        case .internetConnectiomProblem:
            break
        case .parsingError:
            break
        case .serverError(let error):
            message = error.error
        default:
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
    
    private var invalidFormView: some View {
        content
            .onAppear{
                showAlertEmptyFields = true
            }
            .alert(isPresented: $showAlertEmptyFields) {
                Alert(title: Text("Все поля должны быть заполнены!"),
                      message: nil)
            }
    }
    
  private  var content: some View {
        NavigationStack {
        ZStack {
            Color(UIColor.white)
                .ignoresSafeArea()
            VStack(alignment: .center, spacing: 10) {
                Text("Вы адвокат и хотите к нам присоединиться?")
                    .font(.callout)
                    .padding(.top, -80)
                Text("Заполните регистрационную форму, и мы свяжемся с вами для верификации. Все поля обязательны для заполнения")
                    .font(.caption)
                    .padding(.top, -50)
                    .padding(15)
                
                CustomTF(text: $viewModel.lawyerName, placeholder: "Имя", ImageTF: Image(systemName: "person"), isPassword: false, StylesType: .Style1, KeyboardType: .default, color: nil)
                    .padding(5)

                CustomTF(text: $viewModel.lawyerPatronymic, placeholder: "Отчество", ImageTF: Image(systemName: "person"), isPassword: false, StylesType: .Style1, KeyboardType: .default, color: nil)
                    .padding(5)

                
                CustomTF(text: $viewModel.lawyerSurname, placeholder: "Фамилия", ImageTF: Image(systemName: "person"), isPassword: false, StylesType: .Style1, KeyboardType: .default, color: nil)
                    .padding(5)

                CustomTF(text: $viewModel.lawyerPhone, placeholder: "+7", ImageTF: Image(systemName: "phone"), isPassword: false, StylesType: .Style1, KeyboardType: .phonePad, color: nil)
                    .padding(5)

                CustomTF(text: $viewModel.lawyerPassword, placeholder: "Придумайте пароль", ImageTF: Image(systemName: "lock"), isPassword: true, StylesType: .Style1, KeyboardType: .default, color: nil)
                    .padding(5)
    
                Button {
                    viewModel.submitForm()
                } label: {
                    Text("Отправить")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .buttonBorderShape(.roundedRectangle(radius: 20))
                .padding(15)
                .navigationDestination(isPresented: $showOnboardigForLawyer) {
                    WaitingVerificationScreen(data: OnboardingForLawyerData(id: 1, backgroundImage: "backgroundVector", objectImage: "lawyer", primaryText: "Вы напрямую общаетесь с клиентами", secondaryText: "После верификации вы сможете получать заявки"))
                        }
                                              
               }
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
    LawyerRegistrationScreen()
}
