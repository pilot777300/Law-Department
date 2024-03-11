

import SwiftUI

struct LawyerRegistrationScreen: View {
    
    @State var person = Lawyer(firstName: "", secondName: "", surname: "", city: "", phoneNumber: "", avatar: "")
    
    
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGray6)
                .ignoresSafeArea()
            VStack(alignment: .center, spacing: 10) {
                Text("Вы адвокат и хотите к нам присоединиться?")
                    .font(.callout)
                    .padding(.top, -80)
                Text("Заполните регистрационную форму, и мы свяжемся с вами для верификации. Все поля обязательны для заполнения")
                    .font(.caption)
                    .padding(.top, -50)
                    .padding(15)
                
                LawyerAvatarView(image: Image("noPicture"))
                    .padding(15)
                
                TextField(
                    "Имя",text: $person.firstName)
                .disableAutocorrection(true)
                .frame(height: 5)
                .font(.footnote)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                 .padding()
                
                TextField(
                    "Отчество",text: $person.secondName)
                .disableAutocorrection(true)
                .frame(height: 5)
                .font(.footnote)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                 .padding()
                
                TextField(
                    "Фамилия",text: $person.surname)
                .disableAutocorrection(true)
                .frame(height: 5)
                .font(.footnote)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                 .padding()
                
                TextField(
                    "Номер телефона",text: $person.phoneNumber)
                .disableAutocorrection(true)
                .frame(height: 5)
                .font(.footnote)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                 .padding()
                
                TextField(
                    "Город",text: $person.city)
                .disableAutocorrection(true)
                .frame(height: 5)
                .font(.footnote)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                 .padding()
                
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
    }
}

#Preview {
    LawyerRegistrationScreen()
}
