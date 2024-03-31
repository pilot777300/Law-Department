
import SwiftUI

struct OnBoardingScreen: View {
    @State  var state: AppState
   // @ObservedObject var x = OnBoardingObserver()
    @State private var currentTab = 0
    var body: some View {
                    switch state {
        case .onbrd:
            TabView(selection: $currentTab,
                    content:  {
                ForEach(OnboardingData.list) { viewData in
                    OnBoardingView(data: viewData, appState: $state)
                        .tag(viewData.id)
                }
            })
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        case .autorized:
            AuthorizedUserMainScreen()
        default: Text("")
                        
        }
    }
}

#Preview {
    OnBoardingScreen(state: .onbrd)
}

