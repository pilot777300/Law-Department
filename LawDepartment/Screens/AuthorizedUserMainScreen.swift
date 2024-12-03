
import SwiftUI
import KeychainSwift

struct AuthorizedUserMainScreen: View {
    @State private var isUserWriting = false
    private let internet = NetworkManager()
    private let keychain = KeychainSwift()
    @State var nameOne = userName//"Пользователь"
  //  @Binding var  state: AppState
    var body: some View {
        NavigationView {
            ZStack {
                Image("backgroundVector")
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                VStack(alignment: .center, spacing: -10) {
                   
                        Text("Здравствуйте, \(nameOne)")
                        .font(.system(.subheadline))
                        .fontWeight(.black)
                        .padding(10)
                
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
            let tokenInPhone = keychain.get("token")
            let name = keychain.get("username")
            print("LOADED MAIN SCREEN")
            print("Keychain Token = \(tokenInPhone ?? "00000")")
            print(".........END OF TOKEN..........")
            print("'''''''KeychAIN USER====::::::::::")
            print(name!)
            print(";;;;;;;END OF NAME::::::::")
            userName = name!
            nameOne = name!
//            let isTokenActive = internet.checkResponce()
//            print(isTokenActive)
//            if isTokenActive {
//                nameOne = name!
//            }
//            nameOne = name!
//           internet.fetchData(urlString: "https://api.6709.ru/v1/user/token-status") { (tokenStatus: TokenStatus?) in
//               let isTokenValid = tokenStatus?.valid
//               print(isTokenValid!)
//                
             //   let data = keychain.read(service: "token")
           //     let tokenInPhone = String(data: data!, encoding: .utf8)
              //  let nameData = keychain.read(service: "name")
             //   let user = String(data: nameData!, encoding: .utf8)
//               if isTokenValid! {
//                   nameOne = name!
//
//               }
            
       //     }
            
        }
    }
}


#Preview {
    AuthorizedUserMainScreen()
}
