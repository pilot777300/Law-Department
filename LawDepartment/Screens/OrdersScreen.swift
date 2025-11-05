
import SwiftUI

struct OrdersScreen: View {
    @StateObject var viewModel: OrderViewModel = .init()
     private var orders = ["Новые", "Все заявки"]
    @State private var selectedItem = "Новые"
    @State private var showNewOrders = true
    @State private var showAlertLosdingErrorAllOrders = false
    
    private var allOrderscontent: some View {
        List(viewModel.allOrders.reversed(), id: \.self) { item in
                let date = Date().formatDate(dateFromServer: item.sentAt)
                OrderView(number: item.clientRequestId, date: date, name: item.clientName, city: item.clientCity, phone: item.clientPhone, adviceType: item.adviceType)
                .modifier(AllOrdersTxtModifiers())
                }
        .modifier(AllOrdersListTxtModifier())
    }
    
    private var newOrdersContent: some View {
        List(viewModel.newOrders, id: \.self) { item in
            let date = Date().formatDate(dateFromServer: item.sentAt)
            NavigationLink() {
                OrderDetailScreen(number: item.clientRequestId, date: date, name: item.clientName, city: item.clientCity, phone: item.clientPhone, adviceType: item.adviceType)
                
            } label:{
                NewOrderView(number: item.clientRequestId, date: date, name: item.clientName, city: item.clientCity, adviceType: item.adviceType)
                    .padding(1)
                    .background(skyBlue)
            }
            .modifier(NewOrdersTxtModifiers())
         }
        .modifier(NewOrdersListTxtModifiers())
    }
    
    private func errorView() -> some View {
        let error = viewModel.error ?? .unknown
        let title = "Проблема с интернет-соединением"
        var message = "Проверьте подключение к интернету"
        switch error {
        case .unknown:
            break
        case .internetConnectiomProblem:
            break
        case .parsingError:
            break
        case .serverError(let error):
            message = error.error
        default:
            break
        }
        return allOrderscontent
            .onAppear{
                showAlertLosdingErrorAllOrders = true
            }
            .alert(isPresented: $showAlertLosdingErrorAllOrders) {
                Alert(title: Text(title),
                      message: Text(message))
            }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Мои Заявки")
                    .modifier(TxtModifierForOrders())
            Picker("", selection: $selectedItem) {
            ForEach(orders, id: \.self) {
            Text($0).tag($0)
                    }
                }
            .onChange(of: selectedItem) { 
            if selectedItem == orders[0] {
                viewModel.fetchNewOrders()
                showNewOrders = true
            } else if
                selectedItem == orders[1] {
                viewModel.fetchAllOrders()
                showNewOrders = false
               }
            }
            .pickerStyle(.segmented)
            .padding(5)
            Spacer()
                if showNewOrders {
                    switch viewModel.newOrderScreenState {
                    case .default:
                        newOrdersContent
                    case .loading:
                        EmptyNewOrderView()
                            .overlay{
                                ProgressView()
                                    .controlSize(.large)
                            }
                    case .success:
                        if viewModel.newOrders.isEmpty{
                            EmptyNewOrderView()
                        } else {
                            newOrdersContent
                                }
                    case .failure:
                        errorView()
                    }
                } else {
                    switch viewModel.allOrdersScreenState {
                    case .default:
                       allOrderscontent
                    case .loading:
                        allOrderscontent
                            .overlay{
                                ProgressView()
                                    .controlSize(.large)
                            }
                    case .success:
                        if viewModel.allOrders.isEmpty{
                            EmptyAllOrdersView()
                        } else {
                            allOrderscontent
                                }
                    case .failure:
                        errorView()
                    }
                }
            }
            .onAppear {
            viewModel.fetchNewOrders()
            }
        }
    }
}


#Preview {
    OrdersScreen()
}
