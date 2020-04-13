//
//  AlbumServices.swift
//  AlbumFetch
//
//  Created by Pedro Alfonso on 4/12/20.
//  Copyright © 2020 Pedro Alfonso. All rights reserved.
//

import Foundation
import Cocoa

typealias CompletionNSImageWithThrow<NSImage> = (() throws -> NSImage) -> Void

class AlbumService {
    private let transport = HttpTransport()
    private let endPoint = "https://itunes.apple.com/lookup?id=909253&entity=album"
    
    func fetchAlbums(completionHandler: @escaping CompletionsWithThrow<Any>) -> Void {
        transport.HTTPRequest(endPoint: endPoint) { result in
            do {
                guard let response = try result() as? Data else {
                    completionHandler({ throw NetworkError.invalidData })
                    return
                }
                
                let albums = try JSONDecoder().decode(Albums.self, from: response)
                print(albums)
                
                completionHandler({ albums })
            } catch let e {
                completionHandler({ throw e })
            }
        }
    }
    
    func fetchPicture(pictureURL: String, completionHandler: @escaping CompletionNSImageWithThrow<NSImage>) -> Void {
        transport.HTTPRequest(endPoint: pictureURL) { result in
            do {
                guard let responseData = try result() as? Data,
                    let image = NSImage(data: responseData) else {
                        completionHandler({ throw NetworkError.invalidData })
                        return
                }
                
                completionHandler({ image })
            } catch let e {
                completionHandler({ throw e })
            }
        }
    }
}
