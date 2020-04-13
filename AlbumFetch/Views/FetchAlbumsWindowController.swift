//
//  FetchAlbumsWindowController.swift
//  AlbumFetch
//
//  Created by Pedro Alfonso on 4/11/20.
//  Copyright © 2020 Pedro Alfonso. All rights reserved.
//

import Cocoa

class FetchAlbumsWindowController: NSWindowController {
    override init(window: NSWindow?) {
        super.init(window: window)
    }
        
    convenience init(contentViewController_: NSViewController) {
        self.init()
            
        contentViewController = contentViewController_
        window = NSWindow(contentViewController: contentViewController_)
            
        setupWindow()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setupWindow() {
        if let window_ = window, let screen = window_.screen {
            let screenRectangle = screen.visibleFrame
                
            // Window will be positionated at the center of the screen
            window_.setFrame(CGRect(x: 0,
                                    y: 0,
                                    width: screenRectangle.width,
                                    height: screenRectangle.height), display: false)
            window_.center()
        }
    }
}
