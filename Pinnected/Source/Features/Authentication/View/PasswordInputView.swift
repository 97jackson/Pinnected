//
//  PasswordInputView.swift
//  Pinnected
//
//  Created by Jackson Patrick on 20/04/25.
//

import SwiftUI

struct PasswordInputView: View {
    @ObservedObject var viewModel: SignupViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            titleView
            emailInputView
            toggleShowPassword
        }
    }
    
    // MARK: - Title Section
    
    /// Displays the title prompt for password input
    var titleView: some View {
        Text("Create a password")
            .font(.title)
            .fontWeight(.semibold)
    }
    
    // MARK: - Password Input Field
    
    /// Custom UITextField styled for password input
    var emailInputView: some View {
        VStack {
            UITextFieldRepresentable(
                text: $viewModel.password,
                placeholder: "Enter Password",
                placeholderFont: .monospacedDigitSystemFont(ofSize: 28, weight: .regular),
                font: .monospacedSystemFont(ofSize: 28, weight: .regular),
                isSecureTextEntry: viewModel.showPassword
            )
            .frame(height: 34)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // MARK: - Toggle Show Password
    
    /// Checkbox-style toggle to show or hide password characters
    var toggleShowPassword: some View {
        HStack {
            Circle()
                .stroke(Color.gray, lineWidth: 1) // Circle border
                .frame(width: 24, height: 24)
                .background(viewModel.showPassword ? Color.primaryFontColor : .clear) // Filled circle when active
                .clipShape(Circle())
                .onTapGesture {
                    viewModel.showPassword.toggle()
                }
            
            Text("Show password")
                .font(.system(size: 16))
                .foregroundColor(Color.gray.opacity(0.5))
        }
        // Allow toggling password visibility by tapping anywhere in the row
        .onTapGesture {
            viewModel.showPassword.toggle()
        }
    }
}
