

import SwiftUI
import CustomTextField


struct LawyerRegistrationScreen: View {
    
    @State private var lawyerName: String = ""
    @State private var lawyerPatronymic: String = ""
    @State private var lawyerSurname: String = ""
    @State private var lawyerPhone: String = "+7"
    @State private var lawyerPassword: String = ""
    @State private var showAlertEmptyFields = false
    @State private var showOnboardigForLawyer = false
    @Environment(\.dismiss) var dismiss
    private var internet = NetworkManager()

    
    var body: some View {
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
                
                CustomTF(text: $lawyerName, placeholder: "Имя", ImageTF: Image(systemName: "person"), isPassword: false, StylesType: .Style1, KeyboardType: .default, color: nil)
                    .padding(5)

                CustomTF(text: $lawyerPatronymic, placeholder: "Отчество", ImageTF: Image(systemName: "person"), isPassword: false, StylesType: .Style1, KeyboardType: .default, color: nil)
                    .padding(5)

                
                CustomTF(text: $lawyerSurname, placeholder: "Фамилия", ImageTF: Image(systemName: "person"), isPassword: false, StylesType: .Style1, KeyboardType: .default, color: nil)
                    .padding(5)

                CustomTF(text: $lawyerPhone, placeholder: "+7", ImageTF: Image(systemName: "phone"), isPassword: false, StylesType: .Style1, KeyboardType: .phonePad, color: nil)
                    .padding(5)

                CustomTF(text: $lawyerPassword, placeholder: "Придумайте пароль", ImageTF: Image(systemName: "lock"), isPassword: true, StylesType: .Style1, KeyboardType: .default, color: nil)
                    .padding(5)
    
                Button {
                    
                    if lawyerName == "" || lawyerPatronymic == "" || lawyerSurname == "" || lawyerPhone == "" {
                        showAlertEmptyFields = true
                    } else {
                        let formattedLawyerPhone = lawyerPhone.replacingOccurrences(of: "+", with: "")
                        internet.registerNewLawyer(Name: lawyerName, Patronymic: lawyerPatronymic, Surname: lawyerSurname, PhoneNumber: formattedLawyerPhone, Password: lawyerPassword)
                       showOnboardigForLawyer = true
                   

                    }
                } label: {
                    Text("Отправить")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .buttonBorderShape(.roundedRectangle(radius: 20))
                .padding(15)
                .alert(isPresented: $showAlertEmptyFields) {
                Alert(title: Text("Все поля должны быть заполнены!"),
                message: nil)
                   } 
                .navigationDestination(isPresented: $showOnboardigForLawyer) {
                    OnBoardingForLawyerScreen()
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
