
import Foundation

struct OnboardingForLawyerData: Hashable, Identifiable {
    let id: Int
    let backgroundImage: String
    let objectImage: String
    let primaryText: String
    let secondaryText: String
    static let list: [OnboardingForLawyerData] = [
        OnboardingForLawyerData(id: 1, backgroundImage: "backgroundVector", objectImage: "lawyer", primaryText: "Вы напрямую общаетесь с клиентами", secondaryText: "Приложение только предоставляет вам заявки"),
        OnboardingForLawyerData(id: 2, backgroundImage: "backgroundVector", objectImage: "lawyer1", primaryText: "Вы самостоятельно заключаете договоры с клиентами", secondaryText: "После верификации вы сможете получать новые заявки")
    ]
}
