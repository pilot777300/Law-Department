

import SwiftUI

struct OrderDetailScreen: View {
    @StateObject var viewModel: OrderViewModel = .init()
    @State var number: String
    @State var date: String
    @State var name: String
    @State var city: String
    @State var phone: String
    @State var adviceType: String
    var body: some View {
        ZStack {
            VStack(alignment:.leading, spacing: 5) {
                Text("Сведения из заявки ")
                    .padding(.leading, 80)
                    .padding(20)
                    .font(.title2)
                Text("№ заявки:  \(number)" )
                    .padding(.leading, 10)
                HStack {
                    Text("Дата:  \(date)")
                        .padding(.leading, 10)
                }
                Text("Имя клиента:  \(name)")
                    .padding(.leading, 10)
                Text("Город:  \(city)")
                    .padding(.leading, 10)
                Text("Телефон клиента:  +\(phone)")
                    .padding(.leading, 10)
                Text("Нужна помощь по делу:  \(adviceType)")
                    .padding(.leading, 10)
                Button {
                  //  print("rrrr")
                } label: {
                    Text("Завершить работу по заявке")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .buttonBorderShape(.roundedRectangle(radius: 15))
                .padding(15)

            }
            .onAppear{
                viewModel.markOrderAsNotNew(requestID: number)
            }
        }
    }
}

#Preview {
  //  OrderDetailScreen()
}
