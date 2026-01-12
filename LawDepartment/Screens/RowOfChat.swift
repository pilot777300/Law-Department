
import SwiftUI

struct RowOfChat: View {
   //  var dataForChat: MessageFromUser
  //  var dataForChat = LawyerChatViewModel()
    @State var userName = ""
    @State var text = ""
    @State var time = ""

    var body: some View {
            VStack( alignment: .leading) {
                
                HStack {
                    Text("\(userName)")
                        .font(.headline)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Spacer()
                    Text("\(time)")
                        .font(.subheadline)
                }
                
                Text("\(text)")
                    .font(.subheadline)
                    .lineLimit(1)
            }
            Spacer()
    }
}

#Preview {
    RowOfChat(userName: "ALLA", text: "NEED HELP", time: "22.22")
}
