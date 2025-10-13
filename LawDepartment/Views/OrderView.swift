
import SwiftUI

struct OrderView: View {
    @State  var number: String
    @State  var date: String
    @State  var name: String
    @State  var city: String
    @State  var phone: String
    @State  var adviceType: String

    var body: some View {
                    VStack (alignment: .leading, spacing: 7) {
                            Text("№ заявки: \(number)")
                                .padding(.leading, 5)
                            HStack {
                                Text("Дата: \(date)")
                                    .padding(.leading, 5)
                            }
                            Text("Имя клиента: \(name)")
                                .padding(.leading, 5)
                        Text("Город: \(city)")
                            .padding(.leading, 5)
                        HStack {
                            Text("Телефон клиента:")
                                .padding(.leading, 5)
                            Button(action: {
                                         let link = "tel://+"
                                         let phoneNumberformatted = link + phone
                                         guard let url = URL(string: phoneNumberformatted) else { return }
                                         UIApplication.shared.open(url)
                                        }) {
                                        Text("+\(phone)")
                                         .foregroundColor(.blue)
                           }
                        }
                            Text("Нужна помощь по делу: \(adviceType)")
                                .padding(.leading, 5)
        }
    }
}
#Preview {
    OrderView(number: "11", date: "45643", name: "aaaa", city: "fffffff", phone: "79263463295", adviceType: "desdf")
}
