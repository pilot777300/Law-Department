

import Foundation

struct Template: Identifiable {
    var id = UUID()
    var name: String
    var url: URL?
}

let listOfTemplates = [
    Template(name: "Апелляционная жалоба на решение суда", url: Bundle.main.url(forResource: "Appeal", withExtension: "docx")),
    Template(name: "Исковое о расторжении брака", url: Bundle.main.url(forResource: "Divorce", withExtension: "docx")),
    Template(name: "Иск о разделе имущества", url: Bundle.main.url(forResource: "Razdel", withExtension: "docx"))
]



