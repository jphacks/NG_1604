//
//  MatchingEntranceViewController.swift
//  OASIS
//
//  Created by 後藤誉昌 on 2016/11/02.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MatchingEntranceViewController: ButtonBarPagerTabStripViewController, Storyboardable {

    // MARK: - Outlet

    // MARK: - Property
    static let storyboardName = "MatchingEntrance"

    // MARK: - Lifecycle
    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [MatchingRecommendationViewController.makeFromStoryboard(), MatchingResultViewController.makeFromStoryboard()]
    }

    // MARK: - Action

    // MARK: - Public

    // MARK: - Private
}
