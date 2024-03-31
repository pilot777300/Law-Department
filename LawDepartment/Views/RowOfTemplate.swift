
import SwiftUI
import QuickLook

struct RowOfTemplate: View {
    @State var url: URL?
    var body: some View {
        List(listOfTemplates) { item in
            VStack {
                HStack {
                    Text(item.name)
                        .padding(10)
                    Spacer()
                    Image("downloadIcon")
                        .padding(10)
                        .onTapGesture {
                            url = item.url
                        } .quickLookPreview($url)
                }
            }
        }
    }
}

#Preview {
    RowOfTemplate()
}
