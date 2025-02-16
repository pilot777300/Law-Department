
import Foundation
import SwiftUI

struct HeaderTxtModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.system(.subheadline))
            .fontWeight(.black)
            .padding(10)
    }
}
