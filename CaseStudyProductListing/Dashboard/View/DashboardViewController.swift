//
//  DashboardViewController.swift
//  CaseStudyProductListing
//
//  Created by Atul Vishnoi on 14/07/23.
//

import UIKit

final class DashboardViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView?

    fileprivate var viewModel: DashboardViewModelProtocol?
    fileprivate var router: DashboardRouterProtocol?

    // MARK: - View Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRouter()
    }

    // MARK: - Configurations
    private func configureRouter() {
        router?.viewController = self
    }
}

// MARK: - UITableViewDataSource
//extension DashboardViewController: UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//    }
//}

// MARK: - Create Function
extension DashboardViewController {
    static func create(
        viewModel: DashboardViewModelProtocol,
        router: DashboardRouterProtocol
    ) -> DashboardViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dashboardVC = storyboard.instantiateViewController(withIdentifier: "Dashboard") as? DashboardViewController
        dashboardVC?.viewModel = viewModel
        dashboardVC?.router = router
        return dashboardVC
    }
}
