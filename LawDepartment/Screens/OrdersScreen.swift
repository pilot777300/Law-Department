
import SwiftUI

struct OrdersScreen: View {
 
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
            .onChange(of: selectedItem){ value in
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
                    List(0..<5) { item in
                        NavigationLink() {
                            OrderDetailScreen(orderData: Order(id: UUID(), clientRequestId: "", adviceType: "", sentAt: "", clientName: "", clientPhone: "", isNew: false, takenToWork: false, serviceProvided: false, closed: false))
                        } label:{
                            OrderView(orderData: Order(clientRequestId: "", adviceType: "", sentAt: "", clientName: "", clientPhone: "", isNew: false, takenToWork: false, serviceProvided: false, closed: false))
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
                } else {
                    List(0..<5) { item in
                            OrderView(orderData: Order(clientRequestId: "", adviceType: "", sentAt: "", clientName: "", clientPhone: "", isNew: false, takenToWork: false, serviceProvided: false, closed: false))
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
                    
                }
            }
        }
    }
}

#Preview {
    OrdersScreen()
}
