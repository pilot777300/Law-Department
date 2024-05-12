
import SwiftUI

struct AuthorizedUserMainScreen: View {
    @State private var isUserWriting = false
    private let internet = NetworkManager()
    private let keychain = KeychainHelper.standart
  //  @Binding var  state: AppState
    var body: some View {
        NavigationView {
            ZStack {
                Image("backgroundVector")
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                VStack(alignment: .center, spacing: -10) {
                   
                        Text("Здравствуйте, \(userName)")
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
            print("LOADED MAIN SCREEN")
//            internet.fetchData(urlString:"https://api.6709.ru/v1/user/client/sign-up") { (tokenChecker: Token?) in
//                let tokenOnServer = tokenChecker?.token
//                print(tokenOnServer!)
//                
             //   let data = keychain.read(service: "token")
           //     let tokenInPhone = String(data: data!, encoding: .utf8)
              //  let nameData = keychain.read(service: "name")
             //   let user = String(data: nameData!, encoding: .utf8)
             //   if tokenOnServer == tokenInPhone {
                  //  userName = user!
                    print("TOKEN ON SERVER:::::::")
                  //  print(tokenOnServer!)
                    print(":::::END OF TOKEN ON SERVER:::::")
                    print("-----TOKEN ON PHONE:---------")
                //    print(tokenInPhone!)
                    print("-------END OF TOKEN ON PHONE---- ")
                    print("-----USER NAME:------")
                    print(userName)
                    print("----END OF USERNAME-------")

             //  }
          //  }
            
        }
    }
}


#Preview {
    AuthorizedUserMainScreen()
}
