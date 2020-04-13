//
//  FetchAlbumViewModel.swift
//  AlbumFetch
//
//  Created by Pedro Alfonso on 4/11/20.
//  Copyright © 2020 Pedro Alfonso. All rights reserved.
//

import Foundation
import Cocoa

enum AlbumColumnNames: String, CaseIterable {
       case cover
       case name
       case price
       case country
       case releaseDate
       case genre
       case tracks
       case explicitness
       
       func getIdentifier() -> String {
           switch self {
           case .cover:
               return "cover"
           case .name:
               return "name"
           case .price:
               return "price"
           case .country:
               return "country"
           case .releaseDate:
               return "releaseDate"
           case .genre:
               return "genre"
           case .tracks:
               return "tracks"
           case .explicitness:
               return "explicitness"
           }
       }
   }

class FetchAlbumsViewModel {
    
    // Properties
    private(set) var albums: [Album]
    private(set) var albumsBackup: [Album]?
    private let albumService = AlbumService()
    
    init(albums: [Album]) {
        self.albums = albums
    }
    
    func createAlbumsBackup() {
        albumsBackup = albums
    }
    
    func removeAlbumsBackup() {
        albums = albumsBackup ?? albums
        albumsBackup = nil
    }
    
    func lookupForString(filerWith: String) {
        albums = albums.filter({ ($0.collectionName?.lowercased().contains(filerWith.lowercased()) ?? false) })
    }
    
    func fetchAlbums(completionHandler: @escaping () -> Void) {
        albumService.fetchAlbums() { [weak self] response in
            do {
                guard let albumsData = try response() as? Albums else { return }
                self?.albums = albumsData.results
                self?.albums.removeFirst()
                completionHandler()
               } catch let e {
                print(e.localizedDescription)
                completionHandler()
               }
        }
    }
    
    func fetchAlbumsCoverPicture(completionHandler: @escaping () -> Void) {
        let dispatchGroup = DispatchGroup()
        
        albums.forEach({
            if let pictureURL = $0.artworkUrl100 {
                dispatchGroup.enter()
                
                albumService.fetchPicture(pictureURL: pictureURL) { _ in
                    dispatchGroup.leave()
                }
            }
        })
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            completionHandler()
        }
    }
    
    func fetchAlbunCoverForIndex(_ rowIndex: Int, completionHandler: @escaping (AnyObject) -> Void) {
        guard albums.indices.contains(rowIndex), let pictureURL = albums[rowIndex].artworkUrl100 else {
            return
        }
        
        albumService.fetchPicture(pictureURL: pictureURL) { response in
            do {
                let picture = try response()
                completionHandler(picture)
            } catch {}
        }
    }
    
    func getNumberOfRows() -> Int {
        let albumsCount = albums.count
        guard albumsCount != 0 else {
            return 20
        }
        return albumsCount
    }
    
    func getCellContent(cellIdentifier: String, rowIndex: Int) -> Any? {
        guard cellIdentifier != "", albums.indices.contains(rowIndex) else {
            return nil
        }
        
        switch AlbumColumnNames(rawValue: cellIdentifier) {
        case .cover:
            return albums[rowIndex].artworkUrl100
        case .name:
            return albums[rowIndex].collectionName
        case .price:
            return "\(albums[rowIndex].currency ?? "$") \(albums[rowIndex].collectionPrice ?? 0)"
        case .country:
            return albums[rowIndex].country
        case .releaseDate:
            return albums[rowIndex].releaseDate?.dateWithFormat()
        case .genre:
            return albums[rowIndex].primaryGenreName
        case .tracks:
            return "\(albums[rowIndex].trackCount ?? 0)"
        case .explicitness:
            return albums[rowIndex].collectionExplicitness
        case .none:
            return nil
        }
    }
   
}
