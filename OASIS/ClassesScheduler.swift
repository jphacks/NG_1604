//
//  ClassesScheduler.swift
//  OASIS
//
//  Created by Yuto Yazaki on 2016/11/04.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import UIKit

class ClassesScheduler {
    var classes: [Bool]

    // MARK: - Initializer
    init() {
        classes = Array(repeating: false, count: 25)
    }

    init(with classes: Classes) {
        self.classes = []
        self.classes += ClassesScheduler.fromCSV(data: classes.mon)
        self.classes += ClassesScheduler.fromCSV(data: classes.tue)
        self.classes += ClassesScheduler.fromCSV(data: classes.wed)
        self.classes += ClassesScheduler.fromCSV(data: classes.thu)
        self.classes += ClassesScheduler.fromCSV(data: classes.fri)
    }

    // MARK: - Public
    func set(value: Bool, at index: Int) {
        classes[index] = value
    }

    func get(at: Int) -> Bool {
        return classes[at]
    }

    func get(on dayOfWeek: DayOfWeek) -> [Bool] {
        let n = dayOfWeek.weekDayNum
        return classes.enumerated().filter { ($0.offset-n) % 5 == 0 }.map { $0.element }
    }

    func get(on dayOfWeek: DayOfWeek, at index: Int) -> Bool {
        return get(on: dayOfWeek)[index]
    }

    func toggle(at: Int) {
        classes[at] = !classes[at]
    }

    func toCSV(on dayOfWeek: DayOfWeek) -> String {
        return ClassesScheduler.toCSV(data: get(on: dayOfWeek))
    }

    // MARK: - Static
    static func toCSV(data: [Bool]) -> String {
        return data.map { String($0 ? "1" : "0") }.joined(separator: ",")
    }

    static func fromCSV(data: String) -> [Bool] {
        return data.components(separatedBy: ",").map { $0 == "1" ? true : false }
    }
}
