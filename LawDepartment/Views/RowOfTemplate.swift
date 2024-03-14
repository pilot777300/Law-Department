
import SwiftUI

struct RowOfTemplate: View {
    @State var fileName = "no file chosen"
    @State var openFile = false
    var body: some View {
        VStack {
            HStack {
                Text("Апелляционная жалоба")
                    .padding(10)
                Spacer()
                Image("downloadIcon")
                    .padding(10)
                    .onTapGesture {
                        print("Tapped")
                        self.openFile.toggle()
                    loadTxt()
                    }
                
                   // .fileImporter( isPresented: $openFile, allowedContentTypes: [.pdf, .content, .font, .rtf, .text], allowsMultipleSelection: false, onCompletion: {
//                             (Result) in
//                             do{
//                                 let fileURL = try Result.get()
//                                 print(fileURL)
//                                 self.fileName = fileURL.first?.lastPathComponent ?? "file not available"
//                                 
//                                
//                                 
//                             }
//                             catch{
//                                print("error reading file \(error.localizedDescription)")
//                             }
//                             
//                         })
            }
        }
    }
    func loadTxt() {
     
        
        if let filepath = Bundle.main.path(forResource: "Appeal", ofType: "docx") {
            do {
                let contents = try String(contentsOfFile: filepath)
                print(contents)
            } catch {
                print("contents could not be loaded")
            }
        } else {
            print("example.txt not found!")
        }
    }
}

#Preview {
    RowOfTemplate()
}
