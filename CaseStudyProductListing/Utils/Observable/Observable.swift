//
//  Observable.swift
//  CaseStudyProductListing
//
//  Created by Atul Vishnoi on 14/07/23.
//

import Foundation
//https://fitzafful.medium.com/data-binding-in-mvvm-on-ios-714eb15e3913#:~:text=Data%20Binding%20is%20simply%20the,but%20to%20other%20patterns%20too.

class Observable<T> {

    var value: T {
        didSet {
            listener?(value)
        }
    }

    private var listener: ((T) -> Void)?

    init(_ value: T) {
        self.value = value
    }

    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}
