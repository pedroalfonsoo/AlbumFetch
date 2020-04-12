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
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
       // The 'FetchAlbumWindowController' object, will be set on the 'WindowController'
        let mainWindowController = FetchAlbumWindowController(contentViewController_: FetchAlbumViewController())
        mainWindowController.showWindow(self)
    }
}

