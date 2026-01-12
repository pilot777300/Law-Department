
import SwiftUI
import ExyteChat

struct ChatScreen: View {
    @ObservedObject var viewModel = ChatViewModel()
    @State private var showAlertRequestFailed = false
   @Binding  var isUserWriting: Bool
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            switch viewModel.screenState {
            case .default:
                content
            case .loading:
                content
                    .overlay(
                        ProgressView()
                    )
            case .success:
                content
            case .failure:
                errorView()
            }
            
        }
    }
    
    private func errorView() -> some View {
        let error = viewModel.error ?? .unknown
        let title = "Внимание"
        var message = " "
        switch error {
        case .internetConnectiomProblem:
            break
        case .parsingError:
            break
        case .serverError(let error):
            message = error.error
        case .unknown:
            break
        }
        return content
            .onAppear{
                showAlertRequestFailed = true
            }
            .alert(isPresented: $showAlertRequestFailed) {
                Alert(title: Text(title),
                      message: Text(message))
            }
    }
    
    private var content: some View {
         NavigationStack {
                 Text(viewModel.userName)
            VStack {
                List {
                    ForEach(viewModel.messages, id: \.self) { msg in
                        ChatContentMessage(contentMessage: msg, isUserWriting: isUserWriting)
                    }
                }
                .listRowSeparator(.hidden)
            }
            .scrollContentBackground(.hidden)
            HStack {
                TextEditor( text: $viewModel.typingMessage)
                    .scrollContentBackground(.hidden)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.black, lineWidth: 0.5)
                    )
                    .frame(maxHeight: CGFloat(40))
                
                Button {
                 //   isUserWriting = true
                   // viewModel.messages.append(viewModel.typingMessage)
                    viewModel.sendMessage(message: viewModel.typingMessage)
                    viewModel.typingMessage = ""
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
