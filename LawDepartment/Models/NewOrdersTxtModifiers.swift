
import Foundation
import SwiftUI

struct NewOrdersTxtModifiers: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listRowBackground(
                RoundedRectangle(cornerRadius: 15)
                    .background(.clear)
                    .foregroundColor(skyBlue)
                    .padding(
                        EdgeInsets(
                            top: 2,
                            leading: 5,
                            bottom: 2,
                            trailing: 5
                    )
                )
            )
    }
}
