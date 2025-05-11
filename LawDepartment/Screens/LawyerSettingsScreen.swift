
import SwiftUI
import KeychainSwift

struct LawyerSettingsScreen: View {
   // @State  var lawyer: Lawyer
    let keychain = KeychainSwift()
    @State private var lawyerName = ""
    @State private var lawyerPatronymic = ""
    @State private var lawyerSurname = ""
    @State private var isActive = false
    @State private var showAlert = false
    @State private var isLawyerVerificated = false
    @ObservedObject var internet = NetworkManager()
    var body: some View {
        NavigationStack {
            Text("\(lawyerName) \(lawyerPatronymic) \(lawyerSurname)")
                .font(.title3)
                .padding(15)
            Spacer()
            VStack (alignment: .leading) {
                HStack {
                    Circle()
                        .fill(isActive ? Color.green : Color.red)
                        .frame(width: 10, height: 10)
                    Text(isActive ? "Активен" : "Не активен")
                }
                .padding(10)
                Toggle("Готов получать заявки", isOn: $isActive)
                    .padding(15)
                    .onChange(of: isActive) { state in
                        if isActive {
                            print("toggled to ON")
                        } else {
                            print("toggled to OFF")
                        }
                    }
                //   Spacer()
                Button(action: {
                    showAlert = true
                })
                {
                    Text("Выйти из системы")
                        .frame(maxWidth: 300, alignment: .center)
                        .padding(15)
                        .foregroundColor(.red)
                }
                .navigationDestination(isPresented: $isLawyerVerificated) {
                    AuthorizedUserMainScreen()
                }
                .alert("Внимание!", isPresented: $showAlert) {
                    Button("Отменить", role: .cancel) {}
                    Button("Удалить", role: .destructive) {
                        internet.deleteLawyer()
                        isLawyerVerificated = true 
                    }

                } message: {
                    Text("Ваша учетная запись будет удалена с сервера")
                }
                Spacer()
            }
            .onAppear(perform: {
                lawyerName = keychain.get("lawyerName") ?? "Пользователь"
                lawyerPatronymic = keychain.get("lawyerPatronymic") ?? "не"
                lawyerSurname = keychain.get("lawyerSurname") ?? "авторизован"
            })
        }
  }
}

#Preview {
    LawyerSettingsScreen()
}
