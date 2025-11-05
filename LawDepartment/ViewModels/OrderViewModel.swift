
import Foundation
import KeychainSwift

enum FetchNewOrdersScreenState {
    case `default`
    case loading
    case success
    case failure
}

enum FetchAllOrdersScreenState {
    case `default`
    case loading
    case success
    case failure
}


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
    @Published var newOrderScreenState: FetchNewOrdersScreenState = .default
    @Published var allOrdersScreenState: FetchAllOrdersScreenState = .default
    @Published var newOrders = [NewOrder]()
    @Published var allOrders = [NewOrder]()
    var error: AppError?
    
    func fetchNewOrders() {
        newOrderScreenState = .loading
            let token = keychain.get("lawyerToken") ?? "" // <-----проблема. краш при старте
        network.fetchNewOrders(token: token) { [weak self] result in
            Task { @MainActor in
            switch result {
            case .success(let newOrder):
                self!.newOrders = newOrder
                self?.newOrderScreenState = .success
            case .failure(let error):
                self?.error = error
                self?.newOrderScreenState = .failure
                }
            }
        }
    }
    
    func fetchAllOrders() {
        Task {
            allOrdersScreenState = .loading
            let token = keychain.get("lawyerToken")
            network.fetchAllOrders(token: token!) { [weak self] result  in
                switch result {
                case .success(let order):
                    DispatchQueue.main.async {
                        self?.allOrdersScreenState = .success
                        self?.allOrders = order
                    }
                case .failure(let error):
                    self?.error = error
                    self?.allOrdersScreenState = .failure
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
