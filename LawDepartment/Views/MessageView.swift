

import SwiftUI

struct MessageView: View {
    var currentMessage: Message
    @ObservedObject var assignment = ChatDataSouce()
    var body: some View {
        HStack(alignment: .bottom, spacing: 15) {
              Image("noPicture")
                        .resizable()
                        .frame(width: 40, height: 40, alignment: .center)
                        .cornerRadius(20)
            ContentMessage(contentMessage: assignment.DataSource.last ?? "NO msgg", isCurrentUser: false)
            
        }
    }
}

#Preview {
    MessageView(currentMessage: Message(id: UUID(), user: User(name: "Vala", phoneNumber: "fffff"), content: "JJJJJJJJ"))
}
