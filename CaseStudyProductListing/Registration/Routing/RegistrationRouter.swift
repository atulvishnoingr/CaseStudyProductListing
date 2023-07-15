//
//  RegistrationRouter.swift
//  CaseStudyProductListing
//
//  Created by Atul Vishnoi on 15/07/23.
//

import Foundation

protocol RegistrationRouterProtocol {
    var viewController: RegistrationViewController? { get set }
    func routeToDashboardScreen()
}

final class RegistrationRouter: RegistrationRouterProtocol {
    var viewController: RegistrationViewController?

    func routeToDashboardScreen() {
        guard let dashboardModule = DashboardModule().createModule() else { return }
        viewController?.navigationController?.pushViewController(dashboardModule, animated: true)
    }
}
