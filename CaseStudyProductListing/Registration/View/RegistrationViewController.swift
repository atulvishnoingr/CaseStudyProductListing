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
        guard let viewModel = viewModel else { return }
        if let errorMessage = viewModel.errorMessage.value {
            showError(with: errorMessage)
            return
        }
        router?.routeToDashboardScreen()
    }

    // MARK: - Configuration
    private func configureRouter() {
        router?.viewController = self
    }

    // MARK: - bind ViewModel observers
    private func bindObservers() {
        guard let viewModel = viewModel else { return }
        viewModel.errorMessage.bind { [weak self] errorMessage in
            guard let errorMessage = errorMessage else { return }
            self?.showError(with: errorMessage)
        }
    }

    private func showError(with errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - TextField Delegates
//extension RegistrationViewController: UITextFieldDelegate {
////    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
////        true
////    }
//
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        guard let viewModel = viewModel else { return true }
//        if textField == emailField {
//            viewModel.validateEmail(value: textField.text ?? "")
//        } else if textField == nameField {
//            viewModel.validateName(value: textField.text ?? "")
//        } else {
//            viewModel.validatePassword(value: textField.text ?? "")
//        }
//        return true
//    }
//
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        true
//    }
//}

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
