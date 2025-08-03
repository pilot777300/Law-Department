
import SwiftUI

struct NewOrderView: View {
    @State  var number: String
    @State  var date: String
    @State  var name: String
    @State  var city: String
    @State  var adviceType: String

    var body: some View {
                    VStack (alignment: .leading, spacing: 7) {
                            HStack {
                                Text("Дата: \(date)")
                                    .padding(.leading, 5)
                            }
                            Text("Имя клиента: \(name)")
                                .padding(.leading, 5)
                            Text("Город:  \(city)")
                                .padding(.leading, 5)
                            Text("Нужна помощь по делу: \(adviceType)")
                                .padding(.leading, 5)
        }
    }
}
#Preview {
  //  OrderView()
}
