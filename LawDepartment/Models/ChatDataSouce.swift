

import Foundation

class ChatDataSouce: ObservableObject {
    
    @Published var DataSource = ["Добрый день! Я дежурный юрист Игорь Николаевич. Какой у вас вопрос? "]
  //  @Binding  var isUserWriting = false
    
    func SendMessage(chatMessage: String) {
        DataSource.append(chatMessage)
    }
}
