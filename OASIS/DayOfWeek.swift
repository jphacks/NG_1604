//
//  DayOfWeek.swift
//  OASIS
//
//  Created by Yuto Yazaki on 2016/11/04.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import Foundation

enum DayOfWeek: Int {
    case sun, mon, tue, wed, thu, fri, sat

    func weekDayNum() -> Int {
        switch self {
        case .mon, .tue, .wed, .thu, .fri:
            return self.rawValue-1
        case .sun, .sat:
            return 0
        }
    }
}
