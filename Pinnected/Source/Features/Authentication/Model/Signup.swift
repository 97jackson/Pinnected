//
//  Signup.swift
//  Pinnected
//
//  Created by Jackson Patrick on 20/04/25.
//

import Foundation

enum SignupSteps: Int, CaseIterable {
    case email = 1
    case password
    case dateOfBirth
    case gender
    case country
    case curateExperience
    case selectIdeas
    
    var currentStep: Int {
        min(self.rawValue, SignupSteps.country.rawValue)
    }
    var totalSteps: Int {
        return Self.country.rawValue
    }
    
}
