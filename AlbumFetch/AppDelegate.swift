//
//  AppDelegate.swift
//  AlbumFetch
//
//  Created by Pedro Alfonso on 4/11/20.
//  Copyright © 2020 Pedro Alfonso. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    private let diskCacheSize: Int = 500*1024*1024
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // The 'FetchAlbumWindowController' object, will be set on the 'WindowController'
        let mainWindowController = FetchAlbumsWindowController(contentViewController_: FetchAlbumsViewController())
        mainWindowController.showWindow(self)
       
        // Sets up the cache size on disk
        URLCache.configSharedCache(disk: diskCacheSize)
    }
}

