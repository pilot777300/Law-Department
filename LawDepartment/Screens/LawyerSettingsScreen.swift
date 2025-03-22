
import SwiftUI

struct LawyerSettingsScreen: View {
    @State  var lawyer: Lawyer
    @State private var isActive = false
    var body: some View {
        Text("\(lawyer.name) \(lawyer.patronymic) \(lawyer.surname)")
            .font(.title3)
            .padding(15)
        Spacer()
        VStack (alignment: .leading) {
        HStack {
            Circle()
                .fill(isActive ? Color.green : Color.red)
                .frame(width: 10, height: 10)
            Text(isActive ? "Активен" : "Не активен")
        }
        .padding(10)
            Toggle("Готов получать заявки", isOn: $isActive)
                .padding(15)
        Spacer()
            Spacer()
          

    }
    }
}

#Preview {
    LawyerSettingsScreen(lawyer: Lawyer(name: "ddd", patronymic: "kkkk", surname: "llll", city: "", phone: ""))
}
