
import SwiftUI

struct OrdersScreen: View {
 
     private var orders = ["Новые", "Все заявки"]
    @State private var selectedItem = "Новые"
    var body: some View {
        ZStack {
         //   .background(Color.white)
          //  Image("backgroundVector")
           //     .ignoresSafeArea()
            VStack(alignment: .center, spacing: 5) {
                Spacer()
                Spacer()
                Spacer()
            Text("Мои Заявки")
                .font(.title3)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding(30)
            
                ScrollViewReader { proxy in
                        Picker("", selection: $selectedItem) {
                            ForEach(orders, id: \.self) {
                                Text($0).tag($0)
                                       }
                        }
                        .onChange(of: selectedItem){ value in
                            if selectedItem == orders[0] {
                                proxy.scrollTo(0, anchor: .leading)        } else if selectedItem == orders[1] {
                                    proxy.scrollTo(1, anchor: .leading)
                                }
                        }
                        .pickerStyle(.segmented)
                        //.background(.gray .opacity(0.1))
                      //  .foregroundColor(.blue)
                        .padding(5)

                VStack {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(0..<2) { i in
                                    OrderView(orderData: Order(date: "22/54/2323", time: "12/56", userName: "", phoneNumber: "", typeOfHelp: ""))
                                
                                                            //Text("Example \(i)")
                                   // .font(.title)
                                    .frame(width: 400, height: 600)
                                   // .background(Color.red)
                                    .cornerRadius(20)
                                    .clipShape(UnevenRoundedRectangle(topLeadingRadius: 20, bottomLeadingRadius: 20, bottomTrailingRadius: 20, topTrailingRadius: 20))
                                    .id(i)
                                
                            }
                        }
                        Spacer()
                      }
                   }
                }
            }
        }
    }
}

#Preview {
    OrdersScreen()
}
