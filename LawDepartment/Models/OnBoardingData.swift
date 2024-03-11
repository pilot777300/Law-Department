

import Foundation

struct OnboardingData: Hashable, Identifiable {
    let id: Int
    let backgroundImage: String
    let objectImage: String
    let primaryText: String
    let secondaryText: String
    static let list: [OnboardingData] = [
        OnboardingData(id: 0, backgroundImage: "backgroundVector", objectImage: "Justice", primaryText: "Все консультации адвокатов бесплатные", secondaryText: "Да, это так. В нашем приложении за консультации платить не нужно"),
        OnboardingData(id: 1, backgroundImage: "backgroundVector", objectImage: "lawyer", primaryText: "Консультируют только адвокаты", secondaryText: "Можете не сомневаться в качестве"),
        OnboardingData(id: 2, backgroundImage: "backgroundVector", objectImage: "lawyer1", primaryText: "Никаких предварительных регистраций", secondaryText: "Мы просим только и мя и номер телефона, поскольку адвокат связжется с вами по телефону")
    ]
}
