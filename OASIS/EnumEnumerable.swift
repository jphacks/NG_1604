//
//  EnumEnumerable.swift
//  OASIS
//
//  Created by 後藤誉昌 on 2016/11/06.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import Foundation

protocol EnumEnumerable {
    associatedtype Case = Self
}

extension EnumEnumerable where Case: Hashable {

    private static var iterator: AnyIterator<Case> {
        var n = 0
        return AnyIterator {
            defer { n += 1 }

            let next = withUnsafePointer(to: &n) {
                UnsafeRawPointer($0).assumingMemoryBound(to: Case.self).pointee
            }
            return next.hashValue == n ? next : nil
        }
    }

    private static func enumerate() -> EnumeratedSequence<AnySequence<Case>> {
        return AnySequence(self.iterator).enumerated()
    }

    static var cases: [Case] {
        return Array(self.iterator)
    }
}
