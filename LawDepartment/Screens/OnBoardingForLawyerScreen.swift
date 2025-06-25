
import SwiftUI

struct OnBoardingForLawyerScreen: View {
    
    
    
    
    @State private var currentTab = 0
    var body: some View {
            TabView(selection: $currentTab,
                    content:  {
                ForEach(OnboardingForLawyerData.list) { viewData in
                    OnBoardingForLayerView(data: viewData)
                        .tag(viewData.id)
                }
            })
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

#Preview {
    OnBoardingForLawyerScreen()
}
