
import SwiftUI

struct OrderView: View {
     var orderData: Order
    var body: some View {
                    VStack (alignment: .leading, spacing: 7) {
                        Text("№ заявки: \(orderData.id)")
                            .padding(.leading, 5)
                        HStack {
                            Text("Дата: \(orderData.date)")
                                .padding(.leading, 5)
                            Text("Время: \(orderData.time)")
                                .padding(.leading, 5)
                        }
                        Text("Имя клиента: \(orderData.userName)")
                            .padding(.leading, 5)
                        Text("Телефон клиента: \(orderData.phoneNumber)")
                            .padding(.leading, 5)
                        Text("Нужна помощь по делу: \(orderData.typeOfHelp)")
                        .padding(.leading, 5)
        }
    }
}
#Preview {
    OrderView(orderData: Order(date: "q", time: "s", userName: "s", phoneNumber: "w", typeOfHelp: "w"))
}
