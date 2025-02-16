
import SwiftUI
import KeychainSwift

struct AuthorizedUserMainScreen: View {
    @State private var isUserWriting = false
    @State private var showAlert = false
    @StateObject private var internet = NetworkManager()
    private let keychain = KeychainSwift()
    @State private var name = ""
    @State private var  state: AppState = .notAutorized
    var body: some View {
        NavigationStack {
            ZStack {
                Image("backgroundVector")
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                VStack(alignment: .center, spacing: -10) {
                    switch state {
                    case .notAutorized, .onbrd:
                        Text("Здравствуйте")
                            .modifier(HeaderTxtModifier())
                    case .autorized:
                        Text("Здравствуйте, \(name)")
                            .modifier(HeaderTxtModifier())
                        Button(action: {
                            showAlert = true
                            print(state)
                        })  {
                            Text("Выйти")
                                .frame(maxWidth: 300, alignment: .trailing)
                                .padding(5)
                        }
                        .alert("Внимание!", isPresented: $showAlert) {
                            Button("Отменить", role: .cancel) {}
                            Button("Удалить", role: .destructive) {
                                internet.deleteUser()
                                state = internet.appState

                            }
                        } message: {
                            Text("Все данные будут удалены с сервера")
                        }
                    }
                    HStack(spacing: -75){
                        NavigationLink(destination: InstructionsScreen()) {
                            Image("instructions")
                                .padding()
                        }
                            NavigationLink(destination: RowOfTemplate()) {
                                Image("templates")
                            }
                    }
                    .padding(5)
                    
                    NavigationLink(destination: ChatScreen( isUserWriting: $isUserWriting))
                            {
                        Image("chatButton")
                            }
                        .padding(-60)
                    NavigationLink(destination: ChoiseScreen())
                            {
                        Image("mainButton")
                            }
                        
                    Text("О приложении")
                        .modifier(TxtModifiers())

                    NavigationLink(destination:
                                    
                        LawyerRegistrationScreen()) {
                        Text("Вход для адвокатов")
                            .modifier(TxtModifiers())
                    }
                }
            }
        }
        .onAppear{
            let tokenInKeychain = keychain.get("token")
            print("Keychain Token = \(tokenInKeychain ?? "00000")")
           // print(".........END OF TOKEN..........")
            //print(state)
            let usernameInKeychain = keychain.get("username")
            name = usernameInKeychain ?? "0000"
            internet.checkResponce(Token: tokenInKeychain ?? "")
            print(state)

        }
    }
}


#Preview {
    AuthorizedUserMainScreen()
}
