

import Foundation
import SwiftUI

struct NewOrdersListTxtModifiers: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scrollContentBackground(.hidden)
            .background(Color.white)
    }
}
