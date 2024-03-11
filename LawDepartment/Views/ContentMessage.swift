

import SwiftUI

struct ContentMessage: View {
 // @State  var DataSource = [String]()
    var contentMessage: String
  //  @ObservedObject var viewModel = ChatDataSouce()
    //@ObservedObject var assignment = ChatDataSouce()
    var isCurrentUser: Bool
    
    var body: some View {
        Text(contentMessage)
                .padding(10)
                .foregroundColor(isCurrentUser ? Color.white : Color.black)
                .background(isCurrentUser ? Color.blue : Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)))
                .cornerRadius(10)
        }
    }


#Preview {
    ContentMessage(contentMessage: "HI its me", isCurrentUser: false)
}
