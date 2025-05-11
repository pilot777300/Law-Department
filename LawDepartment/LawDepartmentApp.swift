

import SwiftUI

@available(iOS 17.0, *)
@main
struct LawDepartmentApp: App {
    
    @State private var launcher = AppLauncher()
    
    var body: some Scene {
        WindowGroup {
            bodyContentView(launchState: launcher.launchState)
                .onAppear{ launcher.load()}
            
        //    FirstAutorizationScreen()
        //   AuthorizedUserMainScreen()
      //      OnBoardingScreen(state: .onbrd)
          //  UserAutorizationScreen()
           // LawyerMainScreen()
          //  LawyerStartigScreen()
          //  OrdersScreen()
          //  OtpFormFieldView()
          //  OtpFormFieldView()
        }
    }
    @available(iOS 17.0, *)
    @ViewBuilder private func bodyContentView(launchState: AppLauncher.LaunchState) -> some View {
        switch launchState {
        case .notVerificatedlawyer:
            OnBoardingForLawyerScreen()
        case .notAutorizedUser:
            AuthorizedUserMainScreen()
       case .verificatedLawyer:
            LawyerStartigScreen()
        case .autorizedUser:
            AuthorizedUserMainScreen()
        }
    }
}
