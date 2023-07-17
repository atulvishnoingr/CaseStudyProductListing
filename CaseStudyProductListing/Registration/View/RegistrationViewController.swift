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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailField?.text = ""
        nameField?.text = ""
        passwordField?.text = ""
    }

    // MARK: - IBActions
    @IBAction private func didTapSignupButton() {
        view.endEditing(true)
        guard let viewModel = viewModel,
              viewModel.isEmailValid(value: emailField?.text ?? ""),
              viewModel.isNameValid(value: nameField?.text ?? ""),
              viewModel.isPasswordValid(value: passwordField?.text ?? "")
        else {
            if let errorMessage = viewModel?.errorMessage.value {
                showError(with: errorMessage)
            }
            return
        }

        router?.routeToDashboardScreen()
    }
}

private extension RegistrationViewController {
    // MARK: - Configuration
    func configureRouter() {
        router?.viewController = self
    }

    // MARK: - bind ViewModel observers
    func bindObservers() {
        guard let viewModel = viewModel else { return }
        viewModel.errorMessage.bind { [weak self] errorMessage in
            guard let errorMessage = errorMessage else { return }
            self?.showError(with: errorMessage)
        }
    }

    func showError(with errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - TextField Delegates
extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard let viewModel = viewModel else { return true }
        if textField == emailField {
            _ = viewModel.isEmailValid(value: textField.text ?? "")
        } else if textField == nameField {
            _ = viewModel.isNameValid(value: textField.text ?? "")
        } else {
            _ = viewModel.isPasswordValid(value: textField.text ?? "")
        }
        return true
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
