
import Foundation
import KeychainSwift


extension Date {
    func formatDate(dateFromServer:String) -> String {
            let dateFormatter = DateFormatter()
        let isoDate = dateFromServer
        let formatter = ISO8601DateFormatter()
        let date = formatter.date(from: isoDate)
           dateFormatter.setLocalizedDateFormatFromTemplate("MMM EEEE HH:mm:ss")
            dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
            dateFormatter.locale = Locale(identifier: "ru")
           let formattedDate = dateFormatter.string(from: date!)
                  return formattedDate
        }
}

@MainActor
final class OrderViewModel: ObservableObject {
    let keychain = KeychainSwift()
    let network = NetworkManager()
    @Published var newOrders = [NewOrder]()
    @Published var allOrders = [NewOrder]()
    var error: AppError?
    
    func fetchNewOrders() {
            let token = keychain.get("lawyerToken")
        network.fetchNewOrders(token: token!) { [weak self] result in
            Task { @MainActor in
            switch result {
            case .success(let newOrder):
                self!.newOrders = newOrder
            case .failure(let error):
                self?.error = error
                }
            }
        }
    }
    
    func fetchAllOrders() {
        Task {
            let token = keychain.get("lawyerToken")
            network.fetchAllOrders(token: token!) { [weak self] result  in
                switch result {
                case .success(let order):
                    DispatchQueue.main.async {
                        self?.allOrders = order
                    }
                case .failure(let error):
                    self?.error = error

                }
            }
        }
    }
    
    func markOrderAsNotNew(requestID: String) {
        let token = keychain.get("lawyerToken")
        network.markOrderAsNotNew(token: token!, requestID: requestID) { [weak self] result in
            switch result {
            case .success(_):
                return
            case .failure(let error):
                self?.error = error
            }
        }
    }
    
}
