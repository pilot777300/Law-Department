

import SwiftUI

struct LawyerAvatarView: View {
  
  let url: String//URL?
  let isOnline: Bool
  
  init(url: String, isOnline: Bool) {
    self.url = url
    self.isOnline = isOnline
    showsOnlineStatus = true
  }
  
  init(url: String) {
    self.url = url
    self.isOnline = false
    showsOnlineStatus = false
  }
  
  private let showsOnlineStatus: Bool
  
  private let placeholderName: String = {
    let name = "lawyer"
    let id = (0...4).randomElement()!
    return "\(name)\(id)"
  }()
  
  var body: some View {
    ZStack {
      Image("lawyer")
        .resizable()
        .frame(width: 37, height: 37)
      
      if showsOnlineStatus {
        Circle()
          .frame(width: 10, height: 10)
          .foregroundColor(isOnline ? .green : .gray)
          .padding([.leading, .top], 25)
      }
    }
  }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        LawyerAvatarView(url: "lawyer", isOnline: true)
          .previewLayout(.fixed(width: 300, height: 300))
    }
}
