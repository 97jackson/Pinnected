//
//  EmailInputView.swift
//  Pinnected
//
//  Created by Jackson Patrick on 20/04/25.
//

import SwiftUI

struct EmailInputView: View {
    @ObservedObject var viewModel: SignupViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            titleView
            emailInputView
        }
    }
    
    // MARK: - Title Section
    
    /// Displays the title prompt for email input
    var titleView: some View {
        Text("What's your email?")
            .font(.title)
            .fontWeight(.semibold)
    }
    
    // MARK: - Email Input Field
    
    /// Custom UITextField styled for email entry using monospaced font
    var emailInputView: some View {
        VStack {
            UITextFieldRepresentable(
                text: $viewModel.email,
                placeholder: "Email Address",
                placeholderFont: .monospacedDigitSystemFont(ofSize: 28, weight: .regular),
                font: .monospacedSystemFont(ofSize: 28, weight: .regular)
            )
            .frame(height: 34)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
