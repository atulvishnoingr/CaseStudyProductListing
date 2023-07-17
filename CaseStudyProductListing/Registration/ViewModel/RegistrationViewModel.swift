//
//  RegistrationViewModel.swift
//  CaseStudyProductListing
//
//  Created by Atul Vishnoi on 14/07/23.
//

import Foundation

protocol RegistrationViewModelProtocol {
    var errorMessage: Observable<String?> { get set }
    func isEmailValid(value: String) -> Bool
    func isNameValid(value: String) -> Bool
    func isPasswordValid(value: String) -> Bool
}

final class RegistrationViewModel: RegistrationViewModelProtocol {
    var errorMessage: Observable<String?> = Observable(nil)

    private func setError(_ message: String) {
        self.errorMessage = Observable(message)
    }

    func isEmailValid(value: String) -> Bool {
        guard !value.isEmpty else {
            setError("Email is empty")
            return false
        }

        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let isEmailValid = emailPred.evaluate(with: value)
        if !isEmailValid {
            setError("Please enter a valid email address")
            return false
        }

        return true
    }

    func isNameValid(value: String) -> Bool {
        if value.count < 3 {
            setError("Name should be at least 3 letters length")
            return false
        }

        return true
    }

    func isPasswordValid(value: String) -> Bool {
        guard !value.isEmpty else {
            setError("Password is empty")
            return false
        }

        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        let isPasswordValid = passwordPred.evaluate(with: value)
        if !isPasswordValid {
            setError(
                "Password must have at least 8 characters with at least 1 number, 1 uppercase & 1 special character"
            )
        return false
        }

        return true
    }
}
