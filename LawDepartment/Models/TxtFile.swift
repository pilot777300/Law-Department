
import Foundation

struct TxtFile: Identifiable {
    var id = UUID()
    var name: String
    var url: URL?
}

let txtFile = [
    Template(name: "Политика по обработке данных", url: Bundle.main.url(forResource: "PrivatePolicy", withExtension: "docx"))
    ]
