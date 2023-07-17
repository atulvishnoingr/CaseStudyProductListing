//
//  Articles.swift
//  CaseStudyProductListing
//
//  Created by Atul Vishnoi on 14/07/23.
//

import Foundation

struct ArticlesResponse: Codable {
    let status: String
    let numResults: Int
    let results: [Article]

    enum CodingKeys: String, CodingKey {
        case status, numResults = "num_results", results
    }
}

struct Article: Codable {
    let title: String
    let media: [Media]?
}

struct Media: Codable {
    let mediaMetaData: [MediaMetaData]?
    enum CodingKeys: String, CodingKey {
        case mediaMetaData = "media-metadata"
    }
}

struct MediaMetaData: Codable {
    let url: String
    let height: Int
    let width: Int
}
