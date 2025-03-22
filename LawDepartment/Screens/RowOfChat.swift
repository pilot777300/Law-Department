
import SwiftUI

struct RowOfChat: View {
     var dataForChat: Message
    var body: some View {
            VStack( alignment: .leading) {
                Text("\(dataForChat.user.name)")
                    .font(.callout)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                Text("\(dataForChat.content)")
                    .font(.caption)
            }
            Spacer()
    }
}

#Preview {
    RowOfChat(dataForChat: Message(id: UUID.init(), user: User(name: "Olga", phoneNumber: ""), content: "Проконсультируйте по насущному вопросу, без которого жизнь не жизнь"))
}
