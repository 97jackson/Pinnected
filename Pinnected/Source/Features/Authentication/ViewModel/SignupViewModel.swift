//
//  SignupViewModel.swift
//  Pinnected
//
//  Created by Jackson Patrick on 20/04/25.
//

import Foundation

class SignupViewModel: ObservableObject {
    @Published var signupSteps: SignupSteps = .email
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false
    
    // MARK: Function to swtich to next step
    func goToNextStep() {
        let nextRawValue = signupSteps.rawValue + 1
        if let nextStep = SignupSteps(rawValue: nextRawValue),
           nextStep.rawValue <= SignupSteps.country.rawValue {
            signupSteps = nextStep
        }
    }
    
    func goToPreviousStep() {
        let previousRawValue = signupSteps.rawValue - 1
        if let previousStep = SignupSteps(rawValue: previousRawValue),
           previousStep.rawValue >= SignupSteps.email.rawValue {
            signupSteps = previousStep
        }
    }
}
