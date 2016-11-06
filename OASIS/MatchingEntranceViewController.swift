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
    override func viewDidLoad() {
        setupPager()
        super.viewDidLoad()
    }

    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [
            MatchingRecommendationViewController.makeFromStoryboard(),
            MatchingResultViewController.makeFromStoryboard()
        ]
    }

    // MARK: - Action

    // MARK: - Public

    // MARK: - Private
    private func setupPager() {
        settings.style.buttonBarMinimumLineSpacing = 0.0
        settings.style.selectedBarHeight = 4
        settings.style.selectedBarBackgroundColor = UIColor.gray.withAlphaComponent(0.5)
        settings.style.buttonBarItemBackgroundColor = UIColor(hex: "2abf88")
        settings.style.buttonBarBackgroundColor = .gray

        containerView.isScrollEnabled = false
        buttonBarView.collectionViewLayout = UICollectionViewFlowLayout()
        buttonBarView.frame.size.height = 40
    }
}
