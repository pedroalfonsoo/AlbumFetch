//
//  Album.swift
//  AlbumFetch
//
//  Created by Pedro Alfonso on 4/11/20.
//  Copyright © 2020 Pedro Alfonso. All rights reserved.
//

import Foundation

struct Albums: Decodable {
    let resultCount: Int
    let results: [Album]
}

struct Album: Decodable {
    let collectionName: String?
    let artworkUrl60: String?
    let collectionPrice: Double?
    let collectionExplicitness: String?
    let trackCount: Int?
    let country: String?
    let currency: String?
    let releaseDate: String?
    let primaryGenreName: String
}
