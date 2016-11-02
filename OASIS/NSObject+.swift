//
//  NSObject+.swift
//  OASIS
//
//  Created by 後藤誉昌 on 2016/11/02.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import Foundation

extension NSObject {

    static var className: String {
        let className = NSStringFromClass(self)
        let range = className.range(of: ".")
        return className.substring(from: range!.upperBound)
    }
}
