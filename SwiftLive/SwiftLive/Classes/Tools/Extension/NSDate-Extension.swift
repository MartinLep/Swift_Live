//
//  NSDate-Extension.swift
//  SwiftLive
//
//  Created by MartinLee on 17/4/10.
//  Copyright © 2017年 MartinLee. All rights reserved.
//

import Foundation

extension NSDate{
    class func getcurrentTime() -> String{
        let currentDate = NSDate()
        let interval = currentDate.timeIntervalSince1970
        return "\(interval)"
        
    }
}
