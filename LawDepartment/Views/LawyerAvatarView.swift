

import SwiftUI

struct LawyerAvatarView: View {
    let image: Image
   
    var body: some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)
            .cornerRadius(50)
            .overlay(
                Circle()
                    .stroke(Color.white, lineWidth: 4)
                    .frame(width: 100, height: 100)
            )
            .shadow(radius: 10)
    }
}

#Preview {
    LawyerAvatarView(image: Image(systemName: "person.fill"))
}
