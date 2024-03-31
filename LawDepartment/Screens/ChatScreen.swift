
import SwiftUI

struct ChatScreen: View {
    @State var typingMessage: String = ""
    @ObservedObject var viewModel = ChatDataSouce()
    @Binding var isUserWriting: Bool
    
    var body: some View {
   
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
                    TextField("Текст сообщения", text: $typingMessage)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(minHeight: CGFloat(30))
                    
                    Button {
                        print(isUserWriting)
                        isUserWriting = true
                        viewModel.SendMessage(chatMessage: typingMessage)
                        print(isUserWriting)
                            } label: {
                       Text("Send")
                    }
                }
                .frame(minHeight: CGFloat(50)).padding()
            }
        }

//#Preview {
//    ChatScreen()
//}
