//
//  ClassSchedule.swift
//  OASIS
//
//  Created by Yuto Yazaki on 2016/11/04.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import UIKit

class ClassSchedule {
    var classes: [Bool]

    init() {
        classes = Array(repeating: false, count: 25)
    }

    func set(value: Bool, on: DayOfWeek, at: Int) {
        
    }

    func get(on: DayOfWeek, at: Int) {
        
    }

    func get(on dayOfWeek: DayOfWeek) -> [Bool] {
        let n: Int = dayOfWeek.weekDayNum()
        return classes.enumerated().filter { ($0.offset-n) % 5 == 0 }.map { $0.element }
    }

    func get(at: Int) -> Bool {
        return classes[at]
    }

    func toggle(at: Int) {
        classes[at] = classes[at] ? false : true
    }

    static func toCSV(data: [Bool]) -> String {
        return data.reduce("") { $0 + ($1 ? "1," : "0,") }
    }

    func toCSV(on dayOfWeek: DayOfWeek) -> String {
        return ClassSchedule.toCSV(data: get(on: dayOfWeek))
    }
}
