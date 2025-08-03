

import SwiftUI
    
struct ChoiseScreen: View {
    @Environment(\.dismiss) var dismiss
    @State private var isChoiseBtnPressed = false
    @State private var showAlertRequestFailed = false
    @StateObject private var viewModel: UserViewModel = .init(service: UserVerificationCheck())
    
    var body: some View {
        NavigationStack {
            switch viewModel.screenState{
            case .loadind:
                content
                    .overlay{
                        ProgressView()
                    }
            case .success:
                content
                
      //             .onAppear{
//                        viewModel.checkIfUserRegistered()
      //                 isChoiseBtnPressed = true

        //           }
                  //  .navigationDestination(isPresented: $isChoiseBtnPressed) {
                        //if viewModel.appState == .autorized {
                             //   RequestHasSentScreen()
                                         //  } else {
                                            //   FirstAutorizationScreen()
                                        //   }
                 //   }
                
            case .failure:
              errorView()
            case .default:
                content
                    .onAppear{
                        viewModel.checkIfUserRegistered()
                    }
            }
            
         
//            ZStack {
//                Image("backgroundVector")
//                    .ignoresSafeArea()
//                VStack(alignment: .center, spacing: -5) {
//                    Text("По какому делу требуется помощь?")
//                        .font(.title3)
//                        .fontWeight(.semibold)
//                        .padding(-5)
//                    Text(" Мы  направим ваш запрос к адвокату в соответствии с его специализацией")
//                        .font(.caption)
//                        .padding(55)
//                    
//                    HStack(spacing: -70) {
//                        Image("forCivil")
//                            .onTapGesture {
//                                if viewModel.appState == .autorized {
//                                    viewModel.sendRequests(adviceType: "Гражданское")
//                                }
//                                isChoiseBtnPressed.toggle()
//
//                            }
//                        Image("forCriminal")
//                            .onTapGesture {
//                                if viewModel.appState == .autorized {
//                                    viewModel.sendRequests(adviceType: "Уголовное")
//                                }
//                                isChoiseBtnPressed.toggle()
//                            }
//                    }
//                    .padding(-60)
//                    HStack(spacing: -70) {
//                        
//                        Image("forBusiness")
//                            .onTapGesture {
//                                if viewModel.appState == .autorized {
//                                    viewModel.sendRequests(adviceType: "Для бизнеса")
//                                }
//                                isChoiseBtnPressed.toggle()
//                            }
//                        
//                        Image("forFamily")
//                            .onTapGesture {
//                                if viewModel.appState == .autorized {
//                                    viewModel.sendRequests(adviceType: "Семейное")
//                                }
//                                isChoiseBtnPressed.toggle()
//                            }
//                    }
//                    HStack(spacing: -70) {
//                        Image("forDTP")
//                            .onTapGesture {
//                                if viewModel.appState == .autorized {
//                                    viewModel.sendRequests(adviceType: "По ДТП")
//                                }
//                                isChoiseBtnPressed.toggle()
//                            }
//                        
//                        Image("forAnother")
//                            .onTapGesture {
//                                if viewModel.appState == .autorized {
//                                    viewModel.sendRequests(adviceType: "Иное")
//                                }
//                                isChoiseBtnPressed.toggle()
//                            }
//                    }
//                    .padding(-60)
//                }
//                .navigationBarBackButtonHidden(true)
//                .toolbar {
//                    ToolbarItem(placement: .topBarLeading) {
//                        Button (action: {
//                            dismiss()
//                        }) {
//                            Label("Back", systemImage: "chevron.left")
//                        }
//                    }
//                }
//                .navigationDestination(isPresented: $isChoiseBtnPressed) {
//                    if viewModel.appState == .autorized {
//                                           RequestHasSentScreen()
//                                       } else {
//                                           FirstAutorizationScreen()
//                                       }
//                }
//            }
        }
//        .onAppear{
//            viewModel.checkIfUserRegistered()
//
//        }
    }
    
    private func errorView() -> some View {
        let error = viewModel.error ?? .unknown
        let title = "Внимание!"
        var message = ""
        switch error {
        case .serverError(let error):
            message = error.error
        case .unknown:
            break
        case .internetConnectiomProblem:
            break
        case .parsingError:
            break
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
    
    var content: some View {
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
                            if viewModel.appState == .autorized {
                                viewModel.sendRequests(adviceType: "Гражданское")
                            }
                            isChoiseBtnPressed = true

                        }
                    Image("forCriminal")
                        .onTapGesture {
                            if viewModel.appState == .autorized {
                                viewModel.sendRequests(adviceType: "Уголовное")
                            }
                            isChoiseBtnPressed = true
                        }
                }
                .padding(-60)
                HStack(spacing: -70) {
                    
                    Image("forBusiness")
                        .onTapGesture {
                            if viewModel.appState == .autorized {
                                viewModel.sendRequests(adviceType: "Для бизнеса")
                            }
                            isChoiseBtnPressed = true
                        }
                    
                    Image("forFamily")
                        .onTapGesture {
                            if viewModel.appState == .autorized {
                                viewModel.sendRequests(adviceType: "Семейное")
                            }
                            isChoiseBtnPressed = true
                        }
                }
                HStack(spacing: -70) {
                    Image("forDTP")
                        .onTapGesture {
                            if viewModel.appState == .autorized {
                                viewModel.sendRequests(adviceType: "По ДТП")
                            }
                            isChoiseBtnPressed = true
                        }
                    
                    Image("forAnother")
                        .onTapGesture {
                            if viewModel.appState == .autorized {
                                viewModel.sendRequests(adviceType: "Иное")
                            }
                            isChoiseBtnPressed = true
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
}

#Preview {
    ChoiseScreen()
}
