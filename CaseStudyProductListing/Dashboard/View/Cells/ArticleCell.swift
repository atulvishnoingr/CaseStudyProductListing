//
//  ArticleCell.swift
//  CaseStudyProductListing
//
//  Created by Atul Vishnoi on 16/07/23.
//

import UIKit
import SDWebImage

final class ArticleCell: UITableViewCell {
    @IBOutlet private(set) weak var titleLabel: UILabel?
    @IBOutlet private(set) weak var articleImageView: UIImageView?

    func configureCell(dataSource: DashboardArticle) {
        titleLabel?.text = dataSource.name
        let animatedImage = SDAnimatedImage(named: "image.gif")
        let imageUrl = URL(string: dataSource.image)
        articleImageView?.sd_setImage(with: imageUrl)
    }
}
