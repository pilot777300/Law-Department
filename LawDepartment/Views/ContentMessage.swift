

import SwiftUI

struct ContentMessage: View {
    var contentMessage: String
  
    @State var isUserWriting: Bool
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 15){
            if isUserWriting {
                Spacer()
                }
            Text(contentMessage)
            
                    .padding(10)
                    .foregroundColor(isUserWriting ? Color.white : Color.black)
                    .background(isUserWriting ? Color.blue : Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)))
                .cornerRadius(10)
        }
    }
}

#Preview {
    ContentMessage(contentMessage: "HI its me", isUserWriting: true)
}
