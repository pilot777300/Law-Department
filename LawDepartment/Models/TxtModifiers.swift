

import Foundation
import SwiftUI

struct TxtModifiers: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.caption)
            .padding()
            .foregroundColor(.blue)
            .underline()
    }
}
