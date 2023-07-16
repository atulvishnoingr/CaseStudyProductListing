//
//  DashboardViewModel.swift
//  CaseStudyProductListing
//
//  Created by Atul Vishnoi on 14/07/23.
//

import Foundation

protocol DashboardViewModelProtocol {
    var errorMessage: Observable<String?> { get set }
    var dashboardDataSource: Observable<DashboardDataSource?> { get set }
    func fetcDashboardArticles()
}

final class DashboardViewModel: DashboardViewModelProtocol {
    var errorMessage: Observable<String?> = Observable(nil)
    var dashboardDataSource: Observable<DashboardDataSource?> = Observable(nil)

    private let networkManager = NetworkManager()
    private let group = DispatchGroup()
    private var emailedArticles: [DashboardArticle]?
    private var sharedArticles: [DashboardArticle]?
    private var viewedArticles: [DashboardArticle]?
    // Top 3 articles
    private let articlesCount = 3

    init() {
        fetcDashboardArticles()
    }

    private func getDashboardArticles(from articles: [Article]) -> [DashboardArticle]? {
        let topThreeArticles = articles[..<articlesCount]
        var dashboardArticles = [DashboardArticle]()
        for article in topThreeArticles {
            let dashboardArticle = DashboardArticle(
                name: article.title,
                image: article.media?.first?.mediaMetaData?.first?.url ?? ""
            )
            dashboardArticles.append(dashboardArticle)
        }
        return dashboardArticles
    }

    func fetcDashboardArticles() {
        // Fetch Emailed Articles
        group.enter()
        networkManager.fetchEmailedArticles { [weak self] response, error in
            guard let self = self else { return }
            if let error = error {
                errorMessage.value = error.localizedDescription
                self.group.leave()
                return
            }

            if let articles = response?.results {
                emailedArticles = getDashboardArticles(from: articles)
            }

            self.group.leave()
        }

        // Fetch Shared Articles
        group.enter()
        networkManager.fetchSharedArticles { [weak self] response, error in
            guard let self = self else { return }
            if let error = error {
                self.errorMessage.value = error.localizedDescription
                self.group.leave()
                return
            }
            if let articles = response?.results {
                sharedArticles = getDashboardArticles(from: articles)
            }

            self.group.leave()
        }

        // Fetch Viewed Articles
        group.enter()
        networkManager.fetchViewedArticles { [weak self] response, error in
            guard let self = self else { return }
            if let error = error {
                errorMessage.value = error.localizedDescription
                self.group.leave()
                return
            }

            if let articles = response?.results {
                viewedArticles = getDashboardArticles(from: articles)
            }

            self.group.leave()
        }

        // Notify observers when all articles are ready
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.dashboardDataSource.value = DashboardDataSource(
                emailedArticles: self.emailedArticles,
                sharedArticles: self.sharedArticles,
                viewedArticles: self.viewedArticles
            )
        }
    }
}

struct DashboardDataSource {
    let emailedArticles: [DashboardArticle]?
    let sharedArticles: [DashboardArticle]?
    let viewedArticles: [DashboardArticle]?
    let sections = ["Emailed Articles", "Shared Articles", "Viewed Articles"]
}

struct DashboardArticle {
    let name: String
    let image: String
}
