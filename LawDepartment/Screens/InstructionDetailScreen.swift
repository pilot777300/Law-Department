

import SwiftUI

struct InstructionDetailScreen: View {
    var detail: Instructions
    var body: some View {
        ScrollView {
            Text(detail.description)
                .lineLimit(nil)
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(width: 350)
                .lineSpacing(5)
                .padding(30)
        }
    }
}

#Preview {
    InstructionDetailScreen(detail: instructionsList[0])
}
