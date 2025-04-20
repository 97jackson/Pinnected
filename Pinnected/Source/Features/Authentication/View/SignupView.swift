//
//  SignupView.swift
//  Pinnected
//
//  Created by Jackson Patrick on 20/04/25.
//

import SwiftUI

struct SignupView: View {
    @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
    @StateObject private var viewModel = SignupViewModel()
    
    var body: some View {
        ZStack {
            Color.backgroundColorDyanmic
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                navigationTitleView
                
                contentView
                
            }
        }
    }
    
    // MARK: Navigation Title View
    var navigationTitleView: some View {
        HStack(spacing: 0) {
            Image("imgCarretLeftGrey")
                .onTapGesture {
                    // Only dismiss if we are currently on the email step
                    if viewModel.signupSteps == .email {
                        viewControllerHolder.dismiss()
                    } else {
                        // Otherwise, move to the previous step
                        viewModel.goToPreviousStep()
                    }                }
            
            Text("Sign up")
                .fontWeight(.semibold)
                .foregroundColor(Color.primaryFontColor)
                .frame(maxWidth: .infinity)
            
        }
        .padding(.leading, 18)
        .padding(.trailing, 54)
        .frame(height: 60)
    }
    
    // MARK: Content View
    var contentView: some View {
        VStack(spacing: 0) {
            switchSignupViews
            
            Spacer()
            
            actionsButtonView
        }
        .padding(.horizontal, 24)
    }
    
    // MARK: Switch between Views
    @ViewBuilder
    var switchSignupViews: some View {
        switch viewModel.signupSteps {
        case .email:
            EmailInputView(viewModel: viewModel)
        case .password:
            PasswordInputView(viewModel: viewModel)
        case .dateOfBirth:
            EmptyView()
        case .gender:
            EmptyView()
        case .country:
            EmptyView()
        case .curateExperience:
            EmptyView()
        case .selectIdeas:
            EmptyView()
        }
    }
    
    // MARK: Progress Bar and  Action Button
    var actionsButtonView: some View {
        VStack(spacing: 16) {
            SignupProgressBarView(progressWidth: CGFloat(viewModel.signupSteps.currentStep), totalProgressWidth: CGFloat(viewModel.signupSteps.totalSteps)
            )
            
            nextButtonView
        }
    }
    
    // MARK: Next Step Button
    var nextButtonView: some View {
        Button {
            // Signup Action
            viewModel.goToNextStep()
        } label: {
            Text("Next")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
        }
        .background(Color.primaryButtonColor)
        .clipShape(Capsule())
        
    }
    
}

#Preview {
    SignupView()
}
