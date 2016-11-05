//
//  MatchingRecommendationViewController.swift
//  OASIS
//
//  Created by 後藤誉昌 on 2016/11/02.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MatchingRecommendationViewController: UIViewController, Storyboardable {

    // MARK: - Outlet

    // MARK: - Property
    static let storyboardName = "MatchingRecommendation"
    private var scheduleVC: ScheduleViewController!

    // MARK: - Lifecycle
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let vc as ScheduleViewController:
            scheduleVC = vc
            scheduleVC.setSchedule(schedule: ClassSchedule())
        default:
            break
        }
    }

    // MARK: - Action

    // MARK: - Public

    // MARK: - Private
}

// MARK: - IndicatorInfoProvider
extension MatchingRecommendationViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "候補")
    }
}
