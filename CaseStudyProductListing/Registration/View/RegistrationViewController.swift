//
//  RegistrationViewController.swift
//  CaseStudyProductListing
//
//  Created by Atul Vishnoi on 14/07/23.
//

import UIKit

final class RegistrationViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var signupButton: UIButton?
    @IBOutlet private weak var emailField: UITextField?
    @IBOutlet private weak var nameField: UITextField?
    @IBOutlet private weak var passwordField: UITextField?

    fileprivate var viewModel: RegistrationViewModelProtocol?
    fileprivate var router: RegistrationRouterProtocol?

    // MARK: - ViewLifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRouter()
    }

    // MARK: - IBActions
    @IBAction private func didTapSignupButton() {
        router?.routeToDashboardScreen()
    }

    // MARK: - Configuration
    private func configureRouter() {
        router?.viewController = self
    }
}

// MARK: - Create function
extension RegistrationViewController {
    static func create(
        viewModel: RegistrationViewModelProtocol,
        router: RegistrationRouterProtocol
    ) -> RegistrationViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let registrationVC = storyboard.instantiateViewController(
            withIdentifier: "Registration"
        ) as? RegistrationViewController
        registrationVC?.viewModel = viewModel
        registrationVC?.router = router
        return registrationVC
    }
}
