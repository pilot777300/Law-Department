

import Foundation

class ChatDataSouce: ObservableObject {
    
    @Published var DataSource = ["Добрый день! Я дежурный юрист Игорь Николаевич. Какой у вас вопрос? "]
    
    func SendMessage(chatMessage: String) {
        DataSource.append(chatMessage)
    }
}
