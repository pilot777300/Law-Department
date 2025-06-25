
import SwiftUI
import KeychainSwift

struct WaitingVerificationScreen: View {
    @StateObject private var viewModel: CheckVerificationViewModel =
        .init(service: VerificationChecker())
    
  //  @State private var isLawyerVerificated = false
    @State private var showAlertRequestFailed = false
    @State private var currentTab = 0
    let data: OnboardingForLawyerData
    @State   var isAnimating: Bool = false
    @State  var showLawyerStartingscreen = false
    @State  var showAlertNotVericatedLawyer = false
    @State  var showStaringAlert = false
    
    var body: some View {
        NavigationStack {
            switch viewModel.screenstate {
            case .default:
                content
            case .loadind:
                content
                    .overlay {
                        ProgressView()
                    }
            case .success:
                content
                    .onAppear{
                       // isLawyerVerificated = true
                        showLawyerStartingscreen = true
                        let x = KeychainSwift()
                        let y = x.get("lawyerToken")
                        print ("TOOOKEEENN: \(y!)")
                    }
            case .failure:
                errorView()
               // showAlertNotVericatedLawyer = true
            }
        }
    }
    
    private func errorView() -> some View {
        let error = viewModel.error ?? .unknown
        let title = "Ошибка выполнения запроса"
        var message = "Повторите попытку позже"
        switch error {
        case .unknown:
            break
        case .internetConnectiomProblem:
            break
        case .parsingError:
            print("PARSING ERROR")
            break
        case .serverError(let error):
            message = error.error
        }
        return content
            .onAppear{
                showAlertRequestFailed = true
            }
            .alert(isPresented: $showAlertRequestFailed) {
                Alert(title: Text(title),
                      message: Text(message))
            }
    }
    
    private var content: some View {
            NavigationStack {
                VStack(spacing: 30) {
                    ZStack {
                        Image(data.backgroundImage)
                            .resizable()
                            .scaledToFit()
                        
                        Image(data.objectImage)
                            .resizable()
                            .scaledToFit()
                            .offset(x: 0, y: 20)
                            .scaleEffect(isAnimating ? 1 : 0.9)
                    }
                    
                    Spacer()
                    Spacer()
                    Text(data.primaryText)
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color(red: 41 / 255, green: 52 / 255, blue: 73 / 255))
                        .padding(15)
                    
                    Text(data.secondaryText)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 250)
                        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 2, y: 2)
                    
                    Spacer()
                    
                    
                    Button(action: {
                        viewModel.checkVerivication()
                        print(viewModel.screenstate)
              
                    }, label: {
                        Text("Начать")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 50)
                            .padding(.vertical, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(
                                        Color(
                                            red: 255 / 255,
                                            green: 115 / 255,
                                            blue: 115 / 255
                                        )
                                    )
                            )
                    })
                    .shadow(radius: 10)
                    .navigationDestination(isPresented: $showLawyerStartingscreen) {
                        LawyerStartigScreen()
                    }
                    .alert(isPresented: $showAlertNotVericatedLawyer) {
                        Alert(title: Text("Дождитесь окончания процедуры подтверждения учетной записи"),
                              message: nil)
                    }
                    
                    Spacer()
                }
                .onAppear(perform: {
                    isAnimating = false
                    withAnimation(.easeOut(duration: 0.5)) {
                    self.isAnimating = true
                    }
                }
                )
            }
        }
    
    
}

#Preview {
    WaitingVerificationScreen(data: OnboardingForLawyerData(id: 1, backgroundImage: "backgroundVector", objectImage: "lawyer", primaryText: "Вы напрямую общаетесь с клиентами", secondaryText: "После верификации вы сможете получать заявки"))
}
