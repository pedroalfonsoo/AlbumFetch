//
//  NSString+Date.swift
//  AlbumFetch
//
//  Created by Pedro Alfonso on 4/12/20.
//  Copyright © 2020 Pedro Alfonso. All rights reserved.
//

import Cocoa

extension String {
    
    func dateWithFormat() -> String? {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withMonth, .withDay, .withYear, .withDashSeparatorInDate]
        
        guard let date = dateFormatter.date(from: self) else {
            return "--"
        }
        
        return dateFormatter.string(from: date)
    }
}
