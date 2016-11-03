//
//  MatchingResultViewController.swift
//  OASIS
//
//  Created by 後藤誉昌 on 2016/11/02.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MatchingResultViewController: UIViewController, Storyboardable {

    // MARK: - Outlet

    // MARK: - Property
    static let storyboardName = "MatchingResult"

    // MARK: - Lifecycle

    // MARK: - Action

    // MARK: - Public

    // MARK: - Private
}

// MARK: - IndicatorInfoProvider
extension MatchingResultViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "結果")
    }
}
