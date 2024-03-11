
import SwiftUI

struct OnBoardingScreen: View {
    
    @State private var currentTab = 0
    @ObservedObject  var state = OnBoardingObserver()
    var body: some View {
        if state.isStopDemostratingOnboard {
            AuthorizedUserMainScreen()
        } else {
            TabView(selection: $currentTab,
                    content:  {
                ForEach(OnboardingData.list) { viewData in
                    OnBoardingView(data: viewData)
                        .tag(viewData.id)
                }
            })
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            //.hidden()
        }
    }
}

#Preview {
    OnBoardingScreen()
}

