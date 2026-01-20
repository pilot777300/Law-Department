
import SwiftUI


struct UserChatContentMessage: View {
  
  let message: String
  let isIncoming: Bool
  let sentAt: String
  //let isMessageRead: Bool
  
  private func chatBubbleTriange(width: CGFloat, height: CGFloat, isIncoming: Bool) -> some View {
    Path { path in
      path.move(to: CGPoint(x: isIncoming ? 0 : width, y: height * 0.5))
      path.addLine(to: CGPoint(x: isIncoming ? width : 0, y: height))
      path.addLine(to: CGPoint(x: isIncoming ? width : 0, y: 0))
      path.closeSubpath()
    }
    .fill(isIncoming ? Color(UIColor.systemGray6) : Color.cometChatBlue)
    .frame(width: width, height: height)
    .shadow(color: .shadow, radius: 2, x: 0, y: 1)
    .zIndex(10)
    .clipped()
    .padding(.trailing, isIncoming ? -1 : 10)
    .padding(.leading, isIncoming ? 10 : -1)
    .padding(.bottom, 12)
      
  }
  
  private var chatBubble: some View {
    RoundedRectangle(cornerRadius: 6)
      .foregroundColor(isIncoming ? Color(UIColor.systemGray6) : .cometChatBlue)
      .shadow(color: .shadow, radius: 2, x: 0, y: 1)
      
  }
  
  private var text: some View {
      Text(message)
      .padding(10)
      .foregroundColor(isIncoming ? .black : .black)
      .modifier(BodyText())
      .background(chatBubble)
      
  }
    
    private var time: some View {
        Text(sentAt)
            .font(.caption2)
            .padding(5)
            .foregroundColor(.black)
            .offset(x: isIncoming ? 15 : -14, y: isIncoming ? 7 : +8)
    }
    
    private var messageWasReadIcon: some View {
        Image("wasReadCheckMark")
            .resizable()
            .frame(width: 20, height: 20)
            .offset(x: -85, y: 5)
            .foregroundColor(.blue)
    }
    
    private var messageWasDeliveredIcon: some View {
        Image("checkmark")
            .resizable()
            .frame(width: 20, height: 20)
            .offset(x: -85, y: 5)
            .foregroundColor(.blue)
    }
  
    var body: some View {

            HStack(alignment: .bottom, spacing: 0) {
                if isIncoming {
                    chatBubbleTriange(width: 15, height: 14, isIncoming: true)
                    ZStack(alignment: .bottom) {
                        text
                          time
                    }
                    Spacer()
                } else {
 //                   Spacer()
//                    text
//                    chatBubbleTriange(width: 15, height: 14, isIncoming: false)
//                   time
                    
                    Spacer()

                    ZStack(alignment: .bottomTrailing) {
                            text
                            
                        time
 
                    }
                        chatBubbleTriange(width: 15, height: 14, isIncoming: false)
                }
            }
       }
}

struct User_ChatContentMessage: PreviewProvider {
  
  private static let chatMessage =
  
    MessageFromUser(fromUserId: 0, fromUserName: "XXX", text: "HELP ME", sentAt: "Today", sendByMe: false)

  static var previews: some View {
    Group {
        
      ChatMessageRow(
        message: "chatMessage",
        isIncoming: true, sentAt: "12.00")
        .previewLayout(.fixed(width: 300, height: 200))
      
      ChatMessageRow(
        message: "chatMessage",
        isIncoming: false, sentAt: "12.00")
        .previewLayout(.fixed(width: 300, height: 200))
      
      ChatMessageRow(
        message: "chatMessage",
        isIncoming: false, sentAt: "12.00")
        .previewLayout(.fixed(width: 300, height: 200))
    }
  }
}

