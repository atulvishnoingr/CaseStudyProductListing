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

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(
            self,
            action: #selector(DashboardViewController.handleRefresh(_:)),
            for: UIControl.Event.valueChanged
        )
        refreshControl.tintColor = UIColor.red

        return refreshControl
    }()

    private var viewModel: DashboardViewModelProtocol?
    private var router: DashboardRouterProtocol?
    private var dashboardDataSource: DashboardDataSource?

    // MARK: - View Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRouter()
        bindObservers()
        configureTableView()
    }
}

private extension DashboardViewController {
    // MARK: - Configurations
    func configureRouter() {
        router?.viewController = self
    }

    func bindObservers() {
        guard let viewModel = viewModel else { return }
        viewModel.dashboardDataSource.bind { [weak self] dataSource in
            self?.dashboardDataSource = dataSource
            self?.tableView?.reloadData()
            guard let refreshControl = self?.refreshControl, refreshControl.isRefreshing else { return }
            refreshControl.endRefreshing()
        }
    }

    func configureTableView() {
        tableView?.dataSource = self
        tableView?.register(cell: ArticleCell.self)
        tableView?.addSubview(refreshControl)
    }

    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        guard let viewModel = viewModel else { return }
        viewModel.fetcDashboardArticles()
    }
}

// MARK: - UITableViewDataSource
extension DashboardViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let dashboardSections = dashboardDataSource?.sections else { return 0 }
        return dashboardSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dashboardDataSource = dashboardDataSource else { return 0 }
        switch section {
        case 0: return dashboardDataSource.emailedArticles?.count ?? 0
        case 1: return dashboardDataSource.sharedArticles?.count ?? 0
        case 2: return dashboardDataSource.viewedArticles?.count ?? 0
        default: return 0
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let dashboardSections = dashboardDataSource?.sections else { return nil }
        return dashboardSections[section]
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var dashboardArticle: DashboardArticle?
        switch indexPath.section {
        case 0:
            dashboardArticle = dashboardDataSource?.emailedArticles?[indexPath.row]
        case 1:
            dashboardArticle = dashboardDataSource?.sharedArticles?[indexPath.row]
        case 2:
            dashboardArticle = dashboardDataSource?.viewedArticles?[indexPath.row]
        default: return UITableViewCell()
        }

        guard let article = dashboardArticle else { return UITableViewCell() }
        let cell: ArticleCell = tableView.dequeueCell(for: indexPath)
        cell.configureCell(dataSource: article)
        return cell
    }
}

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
