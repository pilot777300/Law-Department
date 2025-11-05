
import SwiftUI


struct AuthorizedUserMainScreen: View {
    
    @State private var isUserWriting = false
   // @State private var showAlert = false
    @StateObject  var viewModel: UserViewModel = .init(service: UserVerificationCheck())
   //  @State private var  state: AppState = .notAutorized
  //  @State var txt: URL?
   
    var body: some View {
        NavigationStack {
            ZStack {
                Image("backgroundVector")
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                VStack(alignment: .center, spacing: -10) {
                    switch viewModel.appState {
                    case .notAutorized, .onbrd:
                        Text("Здравствуйте")
                            .modifier(HeaderTxtModifier())
                    case .autorized:
                        Text("Здравствуйте, \(viewModel.userName)")
                            .modifier(HeaderTxtModifier())
                        Button(action: {
                            viewModel.showAlert = true
                        })  {
                            Text("Выйти")
                                .frame(maxWidth: 300, alignment: .trailing)
                                .padding(5)
                        }
                        .alert("Внимание!", isPresented: $viewModel.showAlert) {
                            Button("Отменить", role: .cancel) {}
                            Button("Удалить", role: .destructive) {
                                viewModel.deleteUser()
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
                        .onTapGesture {
                            viewModel.txt = txtFile[0].url
                        } .quickLookPreview($viewModel.txt)
                    
                    NavigationLink(destination:
                                    LawyerRegistrationScreen()) {
                        Text("Вход для адвокатов")
                            .modifier(TxtModifiers())
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .onAppear{
            viewModel.checkIfUserRegistered()
        }
    }
}


#Preview {
    AuthorizedUserMainScreen()
}
