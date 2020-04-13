//
//  NSViewController+Spinner.swift
//  AlbumFetch
//
//  Created by Pedro Alfonso on 4/12/20.
//  Copyright © 2020 Pedro Alfonso. All rights reserved.
//

import Cocoa

extension NSViewController {
    
    func showSpinner() {
        let spinnerDimension: CGFloat = 30
        
        if let window = view.window, let screen = window.screen {
            let spinnerView = NSProgressIndicator(frame: CGRect(origin: CGPoint(x: screen.visibleFrame.width/2 - spinnerDimension,
                                                                                y: screen.visibleFrame.height/2 - spinnerDimension),
                                                                size: CGSize(width: spinnerDimension, height: spinnerDimension)))
            spinnerView.style = .spinning
            view.addSubview(spinnerView)
            spinnerView.startAnimation(self)
        }
    }
  
    func hideSpinner() {
        DispatchQueue.main.async {
            guard let spinnerView: NSProgressIndicator = self.view.subviews.first(where:
                {$0.isKind(of: NSProgressIndicator.self)}) as? NSProgressIndicator else {
                    return
            }
          
            spinnerView.stopAnimation(self)
            spinnerView.removeFromSuperview()
        }
    }
}
