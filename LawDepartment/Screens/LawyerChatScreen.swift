
import SwiftUI
import ExyteChat

struct LawyerChatScreen: View {
    @ObservedObject var viewModel = LawyerChatViewModel()
    @State private var showAlertRequestFailed = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            switch viewModel.screenState {
            case .default:
                content
                    .onAppear {
                        viewModel.fetchMessages()
                    }
            case .loading:
                content
                    .overlay(
                        ProgressView()
                    )
            case .success:
                content
                    .onAppear {
                        viewModel.fetchMessages()
                    }
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
                    List {
                        ForEach(viewModel.usersAndMessage, id: \.self) { msg in
                            let formattedDate =
                            Date().formatDateForChat(dateFromServer: msg.sentAt)
                            ChatMessageRow(message: msg.text, isIncoming: !msg.sendByMe, sentAt: formattedDate)
                                .listRowInsets(.init(top: 7,
                                                    leading: 2,
                                                    bottom: 4,
                                                     trailing: 2))
                                        }
                        .listRowSeparator(.hidden)
                    }
                    .scrollContentBackground(.hidden)
                    .listStyle(GroupedListStyle())
                
                HStack {
                    TextEditor( text: $viewModel.typingMessage)
                        .scrollContentBackground(.hidden)
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(Color.black, lineWidth: 0.5)
                        )
                        .frame(maxHeight: CGFloat(40))
                    
                    Button {
                        viewModel.sendMessage(text: viewModel.typingMessage)
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
               .background(Color .white)

            }
      }
}

#Preview {
  //  LawyerChatScreen(isUserWriting: .constant(true))
}
