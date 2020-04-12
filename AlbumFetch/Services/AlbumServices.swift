//
//  AlbumServices.swift
//  AlbumFetch
//
//  Created by Pedro Alfonso on 4/12/20.
//  Copyright © 2020 Pedro Alfonso. All rights reserved.
//

import Foundation

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
                completionHandler({ albums })
            } catch let e {
                completionHandler({ throw e })
            }
        }
    }
    
    func fetchPictures(picturesURL: [String]) {
        picturesURL.forEach { urlString in
            let operation = BlockOperation(block: {
                if let url = URL(string: urlString) {
                    URLSession(configuration: .default)
                        .downloadTask(with: url, completionHandler: { (tempURL, response, error) in
                        print(response)
                    }).resume()
                }
            })
            
            OperationQueue().addOperation(operation)
        }
    }
}
