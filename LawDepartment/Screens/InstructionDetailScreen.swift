

import SwiftUI

struct InstructionDetailScreen: View {
    @Environment(\.dismiss) var dismiss
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
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button (action: {
                    dismiss()
                }) {
                    Label("Back", systemImage: "chevron.left.circle")
                }
            }
        }

    }
}

#Preview {
    InstructionDetailScreen(detail: instructionsList[0])
}
