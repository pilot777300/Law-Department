

import SwiftUI

struct OnBoardingView: View {
    var data: OnboardingData
    @State private  var isAnimating: Bool = false
        @Binding var appState: AppState
    var body: some View {
        
            VStack(spacing: 30) {
                ZStack {
                    Image(data.backgroundImage)
                        .resizable()
                        .scaledToFit()
                    
                    Image(data.objectImage)
                        .resizable()
                        .scaledToFit()
                        .offset(x: 0, y: 20)
                        .scaleEffect(isAnimating ? 1 : 0.9)
                }
                
                Spacer()
                Spacer()
                Text(data.primaryText)
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color(red: 41 / 255, green: 52 / 255, blue: 73 / 255))
                    .padding(15)
                
                Text(data.secondaryText)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 250)
                    .shadow(color: Color.black.opacity(0.1), radius: 1, x: 2, y: 2)
                
                Spacer()
                
                
                Button(action: {
                    appState = .autorized
                }, label: {
                    Text("Начать")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 50)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(
                                    Color(
                                        red: 255 / 255,
                                        green: 115 / 255,
                                        blue: 115 / 255
                                    )
                                )
                        )
                })
                .shadow(radius: 10)
            Spacer()
            }
            .onAppear(perform: {
                isAnimating = false
                withAnimation(.easeOut(duration: 0.5)) {
                    self.isAnimating = true
                }
            })
    }
}


//#Preview {
//    OnBoardingView(data: OnboardingData.list[2], appState: $appState)
//}
