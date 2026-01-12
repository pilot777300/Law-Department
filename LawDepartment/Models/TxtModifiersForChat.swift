
import Foundation
import SwiftUI

struct TitleText: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(Font.largeTitle.weight(.bold))
      .foregroundColor(.cometChatBlue)
  }
}

struct BodyText: ViewModifier {
  func body(content: Content) -> some View {
    content
      .foregroundColor(.body)
  }
}
