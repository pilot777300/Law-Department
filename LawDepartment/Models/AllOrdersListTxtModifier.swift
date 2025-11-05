

import Foundation
import SwiftUI

struct AllOrdersListTxtModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scrollContentBackground(.hidden)
            .background(Color.init(uiColor: .systemGray6))
    }
}
