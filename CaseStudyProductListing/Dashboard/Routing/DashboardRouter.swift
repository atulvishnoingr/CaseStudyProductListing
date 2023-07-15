//
//  DashboardRouter.swift
//  CaseStudyProductListing
//
//  Created by Atul Vishnoi on 15/07/23.
//

import Foundation

protocol DashboardRouterProtocol {
    var viewController: DashboardViewController? { get  set }
}

final class DashboardRouter: DashboardRouterProtocol {
    var viewController: DashboardViewController?

}
