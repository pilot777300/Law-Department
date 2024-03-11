

import SwiftUI

struct OrderDetailScreen: View {
    var body: some View {
        ZStack {

            VStack(alignment:.leading, spacing: 5){
                Text("Сведения о заявке ")
                    .padding(.leading, 80)
                    .font(.title2)
                Text("№ заявки:")
                    .padding(.leading, 10)
                HStack {
                    
                    Text("Дата: 18.02.2024")
                        .padding(.leading, 10)
                    Text("Время: 18.56")
                        .padding(.leading, 10)
                }
                Text("Имя пользователя: Виктор")
                    .padding(.leading, 10)
                Text("Телефон пользователя: 8(999)9999993")
                    .padding(.leading, 10)
                Text("Нужна помощь по делу: Уголовное")
                    .padding(.leading, 10)
                Button {
                    print("")
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
    OrderDetailScreen()
}
