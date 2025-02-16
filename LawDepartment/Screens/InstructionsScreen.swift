
import SwiftUI

struct InstructionsScreen: View {
    @Environment(\.dismiss) var dismiss
   var detail = Instructions(name: "", description: "")
   var body: some View {
       ZStack {
           Color(UIColor.systemGray6)
               .ignoresSafeArea()
           VStack(alignment: .leading, spacing: 20) {
               Text("Мы подготовили для вас описания ситуаций, с котороми вы можете столкнуться внезапно")
                   .font(.callout)
                   .padding(.top, 50)
                   .padding()
         
                   List(instructionsList) { inst in
                       NavigationLink(destination: InstructionDetailScreen(detail: inst)) {
                           Text(inst.name)
                           }
               }
           }
           .navigationBarBackButtonHidden(true)
           .toolbar {
               ToolbarItem(placement: .topBarLeading) {
                   Button (action: {
                       dismiss()
                   }) {
                       Label("Back", systemImage: "chevron.left.circle")
                   }
               }
           }

       }
   }
}

#Preview {
   InstructionsScreen(detail: Instructions(name: "", description: ""))
}
