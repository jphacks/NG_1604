//
//  Storyboardable.swift
//  OASIS
//
//  Created by 後藤誉昌 on 2016/11/02.
//  Copyright © 2016年 othlotech. All rights reserved.
//


import UIKit

protocol Storyboardable: class {
    associatedtype Instance
    static var storyboardName: String { get }
    static var storyboard: UIStoryboard { get }
    static func makeFromStoryboard() -> Instance
}

extension Storyboardable where Self: UIViewController {

    static var storyboardName: String {
        return className
    }

    static var storyboard: UIStoryboard {
        return UIStoryboard(name: storyboardName, bundle: nil)
    }

    static func makeFromStoryboard() -> Self {
        return storyboard.instantiateInitialViewController()
            as! Self // swiftlint:disable:this force_cast
    }
}
