

import SwiftUI
    
struct ChoiseScreen: View {
    @Environment(\.dismiss) var dismiss
    @State private var isChoiseBtnPressed = false
    @StateObject private var viewModel: UserViewModel = .init(service: UserVerificationCheck())
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("backgroundVector")
                    .ignoresSafeArea()
                VStack(alignment: .center, spacing: -5) {
                    Text("По какому делу требуется помощь?")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(-5)
                    Text(" Мы  направим ваш запрос к адвокату в соответствии с его специализацией")
                        .font(.caption)
                        .padding(55)
                    
                    HStack(spacing: -70) {
                        Image("forCivil")
                            .onTapGesture {
                              //  viewModel.fetchRequests()

                              //  if viewModel.appState == .autorized {
                                  //  viewModel.sendRequestForHelp(type: "Гражданское")
                                  //  print("Гражданское нажато")
                              //  }
                             //   isChoiseBtnPressed.toggle()
                                print(viewModel.appState)

                            }
                        Image("forCriminal")
                            .onTapGesture {
                                if viewModel.appState == .autorized {
                                    viewModel.sendRequests(adviceType: "Уголовное")
                                }
                                print("Уголовное нажато")
                                isChoiseBtnPressed.toggle()
                            }
                    }
                    .padding(-60)
                    HStack(spacing: -70) {
                        
                        Image("forBusiness")
                            .onTapGesture {
                                if viewModel.appState == .autorized {
                               //     viewModel.sendRequestForHelp(type: "Для бизнеса")
                                }
                                print("Для бизнеса нажато")
                                isChoiseBtnPressed.toggle()
                            }
                        
                        Image("forFamily")
                            .onTapGesture {
                                if viewModel.appState == .autorized {
                                 //   viewModel.sendRequestForHelp(type: "Семейное")
                                }
                                print("Семейное нажато")
                                isChoiseBtnPressed.toggle()
                            }
                    }
                    HStack(spacing: -70) {
                        Image("forDTP")
                            .onTapGesture {
                                if viewModel.appState == .autorized {
                               //     viewModel.sendRequestForHelp(type: "По ДТП")
                                }
                                print("По ДТП нажато")
                                isChoiseBtnPressed.toggle()
                            }
                        
                        Image("forAnother")
                            .onTapGesture {
                                if viewModel.appState == .autorized {
                                //    viewModel.sendRequestForHelp(type: "Другое")
                                }
                                print("Иное нажато")
                                isChoiseBtnPressed.toggle()
                            }
                    }
                    .padding(-60)
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
                .navigationDestination(isPresented: $isChoiseBtnPressed) {
                    if viewModel.appState == .autorized {
                                           RequestHasSentScreen()
                                       } else {
                                           FirstAutorizationScreen()
                                       }
                }
            }
        }
        .onAppear{
            viewModel.checkIfUserRegistered()

        }
    }
}

#Preview {
    ChoiseScreen()
}
