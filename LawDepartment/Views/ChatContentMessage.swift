

import SwiftUI

struct ChatContentMessage: View {
    var contentMessage: String
    @State var isUserWriting: Bool
    @StateObject var serviceData: ChatViewModel = .init()
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 15){
            if serviceData.isUserTyping {
                Spacer()
                }
            Text(contentMessage)
            
                    .padding(10)
                    .foregroundColor(serviceData.isUserTyping ? Color.white : Color.black)
                    .background(serviceData.isUserTyping ? Color.blue : Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)))
                .cornerRadius(10)
        }
    }
}

#Preview {
    ChatContentMessage(contentMessage: "HI its me", isUserWriting: true )
}
