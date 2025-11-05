
import SwiftUI

struct EmptyAllOrdersView: View {
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 20) {
                Spacer()
                Image(systemName:"list.clipboard")
                    .resizable()
                    .frame(width: 82.0, height: 115.0)
                Text("Здесь будут отображаться все заявки")
                Spacer()
            }
            .offset(y: -110)
        }
    }
}


#Preview {
    EmptyNewOrderView()
}
