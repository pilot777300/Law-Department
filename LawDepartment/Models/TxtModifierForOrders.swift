

import Foundation
import SwiftUI

struct TxtModifierForOrders: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            .padding(30)
        Spacer()
    }
}
