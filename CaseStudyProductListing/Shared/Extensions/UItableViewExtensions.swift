//
//  UItableViewExtensions.swift
//  CaseStudyProductListing
//
//  Created by Atul Vishnoi on 16/07/23.
//

import UIKit

extension UITableView {
    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }

    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }

    func dequeueCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
         guard let cell = self.dequeueReusableCell(withIdentifier: T.className, for: indexPath) as? T else { fatalError("DequeueReusableCell failed while casting") }
        return cell
    }

    func register<T: UITableViewCell>(cell: T.Type) {
        register(cell.nib, forCellReuseIdentifier: cell.className)
    }

    func register<T: UITableViewHeaderFooterView>(headerFooter: T.Type) {
        register(headerFooter.nib, forHeaderFooterViewReuseIdentifier: headerFooter.className)
    }
}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
}

extension UITableView {
    func register<T: UITableViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.reuseIdentifier)
    }

    func dequeue<T: UITableViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(
            withIdentifier: cellClass.reuseIdentifier, for: indexPath) as? T else {
                fatalError(
                    "Error: cell with id: \(cellClass.reuseIdentifier) for indexPath: \(indexPath) is not \(T.self)")
            }
        return cell
    }
}

extension NSObject {
    class var className: String {
        return "\(self)"
    }
}

extension UIView {
    static var nib: UINib {
        return UINib(nibName: self.className, bundle: nil)
    }
}
