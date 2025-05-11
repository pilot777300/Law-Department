
import SwiftUI

struct OrderView: View {
     var orderData: Order
    var body: some View {
                    VStack (alignment: .leading, spacing: 7) {
                        Text("№ заявки: \(orderData.id)")
                            .padding(.leading, 5)
                        HStack {
                            Text("Дата: \(orderData.sentAt)")
                                .padding(.leading, 5)
                           // Text("Время: \(orderData.time)")
                           //     .padding(.leading, 5)
                        }
                        Text("Имя клиента: \(orderData.clientName)")
                            .padding(.leading, 5)
                        Text("Телефон клиента: \(orderData.clientPhone)")
                            .padding(.leading, 5)
                        Text("Нужна помощь по делу: \(orderData.adviceType)")
                        .padding(.leading, 5)
        }
    }
}
#Preview {
    OrderView(orderData: Order(clientRequestId: "", adviceType: "", sentAt: "", clientName: "", clientPhone: "", isNew: false, takenToWork: false, serviceProvided: false, closed: false))
}
