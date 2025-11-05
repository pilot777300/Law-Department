
import SwiftUI
import KeychainSwift

struct OnBoardingForLayerView: View {
    var data: OnboardingForLawyerData
    @State private  var isAnimating: Bool = false
    @State private var showLawyerStartingscreen = false
    @State private var showAlertNotVericatedLawyer = false
    @State private var showStaringAlert = false
    @Environment(\.dismiss) var dismiss
    @ObservedObject  var internet = NetworkManager()
    var body: some View {
        NavigationStack {
            ZStack {
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
                    
                    
                    //               Button(action: {
                    //                    let keychain = KeychainSwift()
                    //                    keychain.delete("roleLawyer")
                    //                    keychain.delete("lawyerToken")
                    //                    keychain.delete("lawyerName")
                    //                    keychain.delete("lawyerPatronymic")
                    //                    keychain.delete("lawyerSurname")
                    //                    keychain.delete("lawyerPhoneNumber")
                    //                    keychain.delete("lawyerPassword")
                    //                        internet.checkIfLawyerIsVerificated()
                    //                        showLawyerStartingscreen = internet.isLawyerAlreadyVerificated
                    //                    
                    //                    if showLawyerStartingscreen == false {
                    //                        showAlertNotVericatedLawyer = true
                    //                    }
                    //                    print(showLawyerStartingscreen)
                    //                }, label: {
                    //                    Text("Начать")
                    //                        .font(.headline)
                    //                        .foregroundColor(.white)
                    //                        .padding(.horizontal, 50)
                    //                        .padding(.vertical, 16)
                    //                        .background(
                    //                            RoundedRectangle(cornerRadius: 20)
                    //                                .foregroundColor(
                    //                                    Color(
                    //                                        red: 255 / 255,
                    //                                        green: 115 / 255,
                    //                                        blue: 115 / 255
                    //                                    )
                    //                                )
                    //                        )
                    //                })
                    //                .shadow(radius: 10)
                    //                .navigationDestination(isPresented: $showLawyerStartingscreen) {
                    //                    LawyerStartigScreen()
                    //                }
                    //                .alert(isPresented: $showAlertNotVericatedLawyer) {
                    //                    Alert(title: Text("Дождитесь окончания процедуры подтверждения учетной записи"),
                    //                          message: nil)
                    //                }
                    
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
    OnBoardingForLayerView(data: OnboardingForLawyerData.list[0])
}

