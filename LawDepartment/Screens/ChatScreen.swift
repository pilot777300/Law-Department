
import SwiftUI

struct ChatScreen: View {
    @State var typingMessage: String = ""
    @ObservedObject var viewModel = ChatDataSouce()

    var body: some View {
   
            VStack {
                List {
                    ForEach(viewModel.DataSource, id: \.self) { msg in
                   
                        HStack(alignment: .bottom, spacing: 15) {
                              Image("noPicture")
                                        .resizable()
                                        .frame(width: 40, height: 40, alignment: .center)
                                        .cornerRadius(20)
                           
                            ContentMessage(contentMessage: msg, isCurrentUser: false)
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
                        viewModel.SendMessage(chatMessage: typingMessage)
                            } label: {
                       Text("Send")
                    }
                }
                .frame(minHeight: CGFloat(50)).padding()
            }
        }
    }

#Preview {
    ChatScreen()
}
