
import SwiftUI

struct EmptyNewOrderView: View {
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 20) {
                Spacer()
                Image("caseWhite")
                    .resizable()
                    .frame(width: 82.0, height: 82.0)
                Text("Пока что нет новых заявок")
                Spacer()
            }
            .offset(y: -110)
        }
    }
}


#Preview {
    EmptyNewOrderView()
}
