import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    
    var body: some View {
        if isActive {
            if hasSeenOnboarding {
                MainTabView() // Onboarding daha önce görüldüyse ana ekrana geç
            } else {
                OnboardingView(hasSeenOnboarding: $hasSeenOnboarding) // OnboardingView göster
            }
        } else {
            ZStack {
                Color.theme.mintPrimary
                    .ignoresSafeArea()
                
                VStack {
                    Text("Shopping List")
                        .font(.system(size: 48))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

