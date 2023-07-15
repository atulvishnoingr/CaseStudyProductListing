//
//  RegistrationModule.swift
//  CaseStudyProductListing
//
//  Created by Atul Vishnoi on 15/07/23.
//

import UIKit

final class RegistrationModule {
    func createModule() -> UIViewController? {
        let registrationVC = RegistrationViewController.create(
            viewModel: RegistrationViewModel(),
            router: RegistrationRouter()
        )
        return registrationVC
    }
}
