//
//
//import SwiftUI
//
//struct MessageView: View {
//    var currentMessage: Message
//    @ObservedObject var assignment = ChatDataSouce()
//    @State  var isUserWriting: Bool //= false
//    var body: some View {
//        HStack(alignment: .bottom, spacing: 15) {
//            
//            if isUserWriting {
//                Spacer()
//            }
//            ContentMessage(contentMessage: assignment.DataSource.last ?? "NO msgg", isUserWriting: isUserWriting)
//            
//        }
//    }
//}
//
//#Preview {
//    MessageView(currentMessage: Message(id: UUID(), user: User(name: "", phoneNumber: ""), content: ""), isUserWriting: true)
//}
