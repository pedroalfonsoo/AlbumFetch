//
//  FetchAlbumViewModel.swift
//  AlbumFetch
//
//  Created by Pedro Alfonso on 4/11/20.
//  Copyright © 2020 Pedro Alfonso. All rights reserved.
//

import Foundation

struct FetchAlbumViewModel {
    let resultCount: Int
    let albums: [Album]
    
    func getNumberOfRows() -> Int {
        return albums.count
    }
}
