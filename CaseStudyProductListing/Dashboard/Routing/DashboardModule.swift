//
//  DashboardModule.swift
//  CaseStudyProductListing
//
//  Created by Atul Vishnoi on 15/07/23.
//

import UIKit

final class DashboardModule {
    func createModule() -> UIViewController? {
        let dashboardVC = DashboardViewController.create(viewModel: DashboardViewModel(), router: DashboardRouter())
        return dashboardVC
    }
}
