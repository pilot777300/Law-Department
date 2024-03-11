
import SwiftUI

struct RowOfTemplate: View {
    var body: some View {
        VStack {
            HStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    .padding(10)

                Spacer()
                Image("downloadIcon")
                    .padding(10)

            }
        }
    }
}

#Preview {
    RowOfTemplate()
}
