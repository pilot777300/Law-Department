

import SwiftUI
    
struct ChoiseScreen: View {
    @Environment(\.dismiss) var dismiss
    @State private var isChoiseBtnPressed = false
    @State var state: AppState = .notAutorized
    private  let service = NetworkManager()
    
    
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
                                if state == .autorized {
                                    service.sendRequestForHelp(AdviceType: "Гражданское")
                                }
                                isChoiseBtnPressed.toggle()
                                print("Гражданское нажато")
                                
                            }
                        Image("forCriminal")
                            .onTapGesture {
                                if state == .autorized {
                                    service.sendRequestForHelp(AdviceType: "Уголовное")
                                }
                                print("Уголовное нажато")
                                isChoiseBtnPressed.toggle()
                            }
                    }
                    .padding(-60)
                    HStack(spacing: -70) {
                        
                        Image("forBusiness")
                            .onTapGesture {
                                if state == .autorized {
                                    service.sendRequestForHelp(AdviceType: "Для бизнеса")
                                }
                                print("Для бизнеса нажато")
                                isChoiseBtnPressed.toggle()
                            }
                        
                        Image("forFamily")
                            .onTapGesture {
                                if state == .autorized {
                                    service.sendRequestForHelp(AdviceType: "Семейное")
                                }
                                print("Семейное нажато")
                                isChoiseBtnPressed.toggle()
                            }
                    }
                    //  .padding(-20)
                    HStack(spacing: -70) {
                        Image("forDTP")
                            .onTapGesture {
                                if state == .autorized {
                                    service.sendRequestForHelp(AdviceType: "По ДТП")
                                }
                                print("По ДТП нажато")
                                isChoiseBtnPressed.toggle()
                            }
                        
                        Image("forAnother")
                            .onTapGesture {
                                if state == .autorized {
                                    service.sendRequestForHelp(AdviceType: "Другое")
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
                            Label("Back", systemImage: "chevron.left.circle")
                        }
                    }
                }
                .navigationDestination(isPresented: $isChoiseBtnPressed) {
                    if state == .autorized {
                                           RequestHasSentScreen()
                                       } else {
                                           FirstAutorizationScreen()
                                       }
                }
            }
        }
    }
}

#Preview {
    ChoiseScreen()
}
