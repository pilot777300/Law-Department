
import SwiftUI

struct AuthorizedUserMainScreen: View {
    @State var isUserWriting = false
    var body: some View {
        NavigationView {
            ZStack {
                Image("backgroundVector")
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                VStack(alignment: .center, spacing: -10) {
                    
                    Text("Здравствуйте, Иван!")
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

                    NavigationLink(destination: LawyerRegistrationScreen()) {
                        Text("Вход для адвокатов")
                            .modifier(TxtModifiers())
                    }
                }
            }
        }
    }
}

#Preview {
    AuthorizedUserMainScreen()
}
