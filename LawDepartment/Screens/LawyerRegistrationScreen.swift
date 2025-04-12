

import SwiftUI
import CustomTextField


struct LawyerRegistrationScreen: View {
    
    @State var person = Lawyer(name: "", patronymic: "", surname: "", city: "", phone: "")
    @Environment(\.dismiss) var dismiss

    
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
                
                CustomTF(text: $person.name, placeholder: "Имя", ImageTF: Image(systemName: "person"), isPassword: false, StylesType: .Style1, KeyboardType: .default, color: nil)
                    .padding(5)

                CustomTF(text: $person.patronymic, placeholder: "Отчество", ImageTF: Image(systemName: "person"), isPassword: false, StylesType: .Style1, KeyboardType: .default, color: nil)
                    .padding(5)

                
                CustomTF(text: $person.surname, placeholder: "Фамилия", ImageTF: Image(systemName: "person"), isPassword: false, StylesType: .Style1, KeyboardType: .default, color: nil)
                    .padding(5)

                CustomTF(text: $person.phone, placeholder: "Телефон", ImageTF: Image(systemName: "phone"), isPassword: false, StylesType: .Style1, KeyboardType: .default, color: nil)
                    .padding(5)

                
                Button {
                    print("")
                } label: {
                    Text("Отправить")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .buttonBorderShape(.roundedRectangle(radius: 20))
                .padding(15)
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
