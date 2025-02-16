

import SwiftUI

struct LawyerMainScreen: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Text("Мои заявки")
            .font(.title3)
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
        //        NavigationStack {
        //            ZStack {
        //                Image("backgroundVector")
        //                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        //
        //                VStack (alignment: .center, spacing: 30){
        //                    HStack {
        //                        Spacer()
        //                        Button("Новые") {
        //
        //                        }
        //                        .padding(15)
        //                        Spacer()
        //                        Button("Все заявки") {
        //
        //                        }
        //                    }
        //
        //
        //                }
        //                .navigationBarBackButtonHidden(true)
        //                .toolbar {
        //                    ToolbarItem(placement: .topBarLeading) {
        //                        Button (action: {
        //                            dismiss()
        //                        }) {
        //                            Label("Back", systemImage: "chevron.left.circle")
        //                        }
        //                    }
        //                }
        //                NavigationSplitView {  //----
        //                    Text("Мои заявки")
        //                        .font(.title3)
        //                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
        //                    ScrollView(.horizontal, showsIndicators: true) {
        //                        HStack(spacing: 50) {
        //                            Spacer()
        //                            Button("Новые") {
        //
        //                            }
        //                            .padding(15)
        //                            Spacer()
        //                            Button("Все заявки") {
        //
        //                            }
        //                            ForEach(types, id: \.self) { types in
        //                                Text("\(types)")
        //                                    .padding(5)
        //                                    .frame(maxWidth: 300, alignment: .center)
        //
        //                            }
        //                            .padding(10)
        //        //                }
        //          //          }
        //
        //                    List(0 ..< 5) { item in
        //
        //                        NavigationLink {
        //                            OrderDetailScreen()
        //                        } label: {
        //                            VStack (alignment: .leading){
        //                                Text("№ заявки:")
        //                                    .font(.subheadline)
        //
        //
        //                                HStack {
        //
        //                                    Text("Дата: 18.02.2024")
        //                                        .font(.subheadline)
        //
        //                                    Text("Время: 18.56")
        //                                        .font(.subheadline)
        //
        //                                }
        //                                Text("Имя пользователя: Виктор")
        //                                    .font(.subheadline)
        //
        //                                Text("Телефон пользователя: 8(999)9999993")
        //                                    .font(.subheadline)
        //
        //                                Text("Нужна помощь по делу: Уголовное")
        //                                    .font(.subheadline)
        //
        //                            }
        //                        }
        //                    }
        //
        //                    .padding(.top, 5)
        //        //        } detail: {Text("")} //---
        //
        //            }
        //      }
            }
        }
        
        #Preview {
            LawyerMainScreen()
        }
    
