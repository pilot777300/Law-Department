
import SwiftUI

struct AuthorizedUserMainScreen: View {
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
                                .font(.caption)
                                .padding()
                                .foregroundColor(.blue)
                                .underline()
                        }
                        NavigationLink(destination: TemplatesScreen()) {
                            
                        Image("templates")
                            }
                    }
                    .padding(5)
                    
                    NavigationLink(destination: ChatScreen())
                            {
                        Image("chatButton")
                            }
                        .padding(-60)
                    NavigationLink(destination: ChoiseScreen())
                            {
                        Image("mainButton")
                            }
                        
                    Text("О приложении")
                        .font(.caption)
                        .padding()
                        .foregroundColor(.blue)
                        .underline()
                    
                    NavigationLink(destination: LawyerRegistrationScreen()) {
                        Text("Вход для адвокатов")
                            .font(.caption)
                            .padding()
                            .foregroundColor(.blue)
                            .underline()
                    }

                }
            }
       }
    }
}

#Preview {
    AuthorizedUserMainScreen()
}
