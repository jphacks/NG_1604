//
//  Grade.swift
//  OASIS
//
//  Created by 後藤誉昌 on 2016/11/06.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import Foundation

enum Grade: String, EnumEnumerable {
    case undergraduate1 = "学部1年"
    case undergraduate2 = "学部2年"
    case undergraduate3 = "学部3年"
    case undergraduate4 = "学部4年"
    case graduate1 = "院1年"
    case graduate2 = "院2年"

    var id: Int {
        switch self {
        case .undergraduate1: return 1
        case .undergraduate2: return 2
        case .undergraduate3: return 3
        case .undergraduate4: return 4
        case .graduate1: return 5
        case .graduate2: return 6
        }
    }
}
