//
//  SplashScreenView.swift
//  Pinnected
//
//  Created by Jackson Patrick on 19/04/25.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var hideSplashScreen: Bool = false
    
    var body: some View {
        ZStack {
            
            AuthenticationView()
            
            if !hideSplashScreen {
                splashScreenLogo
                    .transition(.move(edge: .top))
                    .zIndex(1) // ensures splash stays on top
            }
        }
        .animation(.easeInOut(duration: 0.6), value: hideSplashScreen)
    }
    // MARK: Splash Scree Logo
    var splashScreenLogo: some View {
        VStack {
            Image(.imgAppLogo)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundColorDyanmic)
        .ignoresSafeArea()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.hideSplashScreen = true
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
