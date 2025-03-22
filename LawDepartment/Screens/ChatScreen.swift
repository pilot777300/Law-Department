
import SwiftUI

struct ChatScreen: View {
    @State private  var typingMessage: String = ""
    @ObservedObject var viewModel = ChatDataSouce()
    @Binding var isUserWriting: Bool
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Text("USERNAME")
        NavigationStack {
            VStack {
                List {
                    ForEach(viewModel.DataSource, id: \.self) { msg in
                        ContentMessage(contentMessage: msg, isUserWriting: isUserWriting)
                    }
                }
                .listRowSeparator(.hidden)
            }
            .scrollContentBackground(.hidden)
            HStack {
                TextEditor( text: $typingMessage)
                    .scrollContentBackground(.hidden)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.black, lineWidth: 0.5)
                    )
                    .frame(maxHeight: CGFloat(40))
                
                Button {
                    print(isUserWriting)
                    isUserWriting = true
                    viewModel.SendMessage(chatMessage: typingMessage)
                    typingMessage = ""
                    print(isUserWriting)
                } label: {
                    Image(systemName: "arrow.right.circle")
                        .resizable()
                        .frame(width: 32.0, height: 32.0)
                }
            }
            .frame(minHeight: CGFloat(50)).padding()
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button (action: {
                        dismiss()
                    }) {
                        Label("Back", systemImage: "chevron.left")
                    }
                }
            }
        }
    }
}

#Preview {
    ChatScreen(isUserWriting: .constant(true))
}
