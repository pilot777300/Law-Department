
import Foundation

enum LawyerRegistrationScreenState {
    case `default`
    case loading
    case success
    case failure
    case invalidForm
}

@MainActor
final class LawyerRegistrationViewModel: ObservableObject {
    @Published var screenState: LawyerRegistrationScreenState = .default
    var error: AppError?
    
    @Published var lawyerName: String = ""
    @Published var lawyerPatronymic: String = ""
    @Published var lawyerSurname: String = ""
    @Published var lawyerPhone: String = "+7"
    @Published var lawyerPassword: String = ""
    
    private let service: LawyerRegistrationService
    
    init (service: LawyerRegistrationService) {
        self.service = service
    }
    
    func submitForm() {
        Task {
            screenState = .loading
           let formattedLawyerPhone = lawyerPhone.replacingOccurrences(of: "+", with: "")
            let model = Lawyer(name: lawyerName, patronymic: lawyerPatronymic,
                        surname: lawyerSurname, city: "", phone: formattedLawyerPhone,
                               password: lawyerPassword)
            service.registerLawyer(model: model) { [weak self] result in
                switch result {
                case .success:
                    self?.screenState = .success
                case .failure(let error):
                    self?.error = error
                    self?.screenState = .failure
                }
            }
        }
    }
   
    
}
