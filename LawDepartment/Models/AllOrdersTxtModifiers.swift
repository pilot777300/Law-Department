

import Foundation
import SwiftUI

struct AllOrdersTxtModifiers: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(5)
            .background(Color.white)
            .listRowBackground(
            RoundedRectangle(cornerRadius: 15)
                            .background(.clear)
                            .foregroundColor(.white)
                            .padding(
                            EdgeInsets(
                            top: 5,
                            leading: 5,
                            bottom: 5,
                            trailing: 5
                    )
                )
            )
    }
}
