//
//  AuthenticationView.swift
//  Pinnected
//
//  Created by Jackson Patrick on 19/04/25.
//

import SwiftUI

struct AuthenticationView: View {
    @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
    
    @State private var counter: Int = 0
    var body: some View {
        ZStack {
            Color.backgroundColorDyanmic
                .ignoresSafeArea(edges: .all)
            
            ScrollView {
                VStack {
                    imageContainerView
                    authenticationActionButtonsView
                    termsAndAgreementTextView
                }
                
            }
            .modifier(ConditionalBounceModifier())            
        }
    }
    
    // MARK: Image Container
    var imageContainerView: some View {
        ZStack(alignment: .bottom) {
            
            Image(.imgAuthentication)
            
            linearGradientFadeView
            
            appLogoAndWelcomeTextView
            
        }
    }
    
    // MARK: App Logo and Welcome Text
    var appLogoAndWelcomeTextView: some View {
        VStack {
            Image(.imgAppLogo)
            
            Text("Welcome to Pinnected")
                .font(.title)
                .foregroundColor(Color.primaryFontColor)
        }
    }
    
    // MARK: Linear Gradient Fade
    var linearGradientFadeView: some View {
        LinearGradient(
            gradient: Gradient(stops: [
                
                .init(color: Color.backgroundColorDyanmic.opacity(1.0), location: 0.41),
                .init(color: Color.backgroundColorDyanmic.opacity(0.0), location: 1.0)
            ]),
            startPoint: .bottom,
            endPoint: .top
        )
        .frame(height: 200)
    }
    
    // MARK: Authentication Action Buttons
    var authenticationActionButtonsView: some View {
        VStack {
            signupButtonView
            loginButtonView
        }
        .padding(.top, 22)
    }
    
    // MARK: Signup Button
    var signupButtonView: some View {
        Button {
            // Signup Action
            print("Signup Button Tapped")
            viewControllerHolder.present {
                SignupView()
            }
        } label: {
            Text("Signup")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
        }
        .background(Color.primaryButtonColor)
        .clipShape(Capsule())
        .padding(.horizontal, 16)
        
    }
    
    // MARK: Login Button
    var loginButtonView: some View {
        Button {
            // Login Action
        } label: {
            Text("Log in")
                .font(.headline)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
        }
        .background(Color.secondaryButtonColor)
        .clipShape(Capsule())
        .padding(.horizontal, 16)
        
    }
    
    // MARK: Terms and Agreement Text
    var termsAndAgreementTextView: some View {
        Text("By continuing, you agree to Pinterest’s Terms of Service and acknowledge you’ve read our Privacy Policy")
            .font(.caption)
            .foregroundColor(.primaryFontColor)
            .multilineTextAlignment(.center)
            .padding(.top, 22)
    }
}


struct ConditionalBounceModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 18, *) {
            content.scrollBounceBehavior(.basedOnSize)
        } else {
            content
        }
    }
}

#Preview {
    AuthenticationView()
}
