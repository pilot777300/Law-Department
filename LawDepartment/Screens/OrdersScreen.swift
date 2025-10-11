
import SwiftUI

struct OrdersScreen: View {
    @StateObject var viewModel: OrderViewModel = .init()
     private var orders = ["Новые", "Все заявки"]
    @State private var selectedItem = "Новые"
    @State private var showNewOrders = true
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Мои Заявки")
                    .font(.title3)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(30)
                Spacer()
            Picker("", selection: $selectedItem) {
            ForEach(orders, id: \.self) {
            Text($0).tag($0)
                    }
                }
            .onChange(of: selectedItem) { 
            if selectedItem == orders[0] {
                showNewOrders = true
            } else if
                selectedItem == orders[1] {
                showNewOrders = false
                    }
            }
            .pickerStyle(.segmented)
            .padding(5)
            Spacer()
                if showNewOrders {
//                    if viewModel.newOrders.isEmpty {
//                        EmptyOrderView()
//                    } else {
                        List(viewModel.newOrders, id: \.self) { item in
                            let date = Date().formatDate(dateFromServer: item.sentAt)
                            NavigationLink() {
                                OrderDetailScreen(number: item.clientRequestId, date: date, name: item.clientName, city: item.clientCity, phone: item.clientPhone, adviceType: item.adviceType)
                                
                            } label:{
                                NewOrderView(number: item.clientRequestId, date: date, name: item.clientName, city: item.clientCity, adviceType: item.adviceType)
                                    .padding(1)
                                    .background(skyBlue)
                            }
                            .listRowBackground(
                                RoundedRectangle(cornerRadius: 15)
                                    .background(.clear)
                                    .foregroundColor(skyBlue)
                                    .padding(
                                        EdgeInsets(
                                            top: 2,
                                            leading: 5,
                                            bottom: 2,
                                            trailing: 5
                                    )
                                )
                            )
                        }
                        .scrollContentBackground(.hidden)
                        .background(Color.white)
                        .onAppear {
                            viewModel.fetchNewOrders()
                        }
                //    }
                } else {
                    List(viewModel.allOrders, id: \.self) { item in
                        let date = Date().formatDate(dateFromServer: item.sentAt)
                        OrderView(number: item.clientRequestId, date: date, name: item.clientName, city: item.clientCity, phone: item.clientPhone, adviceType: item.adviceType)
                                .padding(5)
                                .background(Color.white)
                                .listRowBackground(
                                RoundedRectangle(cornerRadius: 15)
                                                .background(.clear)
                                                .foregroundColor(.white)
                                                .padding(
                                                EdgeInsets(
                                                top: 5,
                                                leading: 5,
                                                bottom: 5,
                                                trailing: 5
                                    )
                                )
                            )
                        }
                    .scrollContentBackground(.hidden)
                    .background(Color.init(uiColor: .systemGray6))
                    .onAppear {
                        viewModel.fetchAllOrders()
                    }
                }
            }
        }
    }
}

#Preview {
    OrdersScreen()
}
