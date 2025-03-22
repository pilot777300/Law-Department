

import SwiftUI

struct OrderDetailScreen: View {
    var orderData: Order
    var body: some View {
        ZStack {

            VStack(alignment:.leading, spacing: 5){
                Text("Сведения о заявке ")
                    .padding(.leading, 80)
                    .padding(20)
                    .font(.title2)
                Text("№ заявки: \(orderData.id)")
                    .padding(.leading, 10)
                HStack {
                    Text("Дата: \(orderData.date)")
                        .padding(.leading, 10)
                    Text("Время: \(orderData.time)")
                        .padding(.leading, 10)
                }
                Text("Имя клиента: \(orderData.userName)")
                    .padding(.leading, 10)
                Text("Телефон клиента: \(orderData.phoneNumber)")
                    .padding(.leading, 10)
                Text("Нужна помощь по делу: \(orderData.typeOfHelp)")
                    .padding(.leading, 10)
                Button {
                    print("rrrr")
                } label: {
                    Text("Завершить работу по заявке")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .buttonBorderShape(.roundedRectangle(radius: 15))
                .padding(15)

            }
        }
    }
}

#Preview {
    OrderDetailScreen(orderData: Order(date: "", time: "", userName: "", phoneNumber: "", typeOfHelp: ""))
}
