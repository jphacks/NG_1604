//
//  MatchingRecommendationViewController.swift
//  OASIS
//
//  Created by 後藤誉昌 on 2016/11/02.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import SwiftTask

class MatchingRecommendationViewController: UIViewController, Storyboardable {

    // MARK: - Outlet
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Property
    static let storyboardName = "MatchingRecommendation"
    var recommends: [User] = []

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        WebAPI.Users.show(uuid: "123456789")
            .success { user, recommends -> Void in
                dump(user)
            }.failure { error, _ in
                print(error)
            }
    }

    override func viewDidAppear(_ animated: Bool) {
        setFlowLayout()
    }

    // MARK: - Action

    // MARK: - Public

    // MARK: - Private
    func setFlowLayout() {
        let layout = CarouselFlowLayout()
        layout.itemSize = CGSize(width: self.collectionView.frame.size.width-40, height: self.collectionView.frame.size.height-40)
        layout.scrollDirection = .horizontal
        layout.spacingMode = CarouselFlowLayoutSpacingMode.fixed(spacing: 0)
        layout.sideItemAlpha = 1.0
        layout.sideItemScale = 1.0
        collectionView.collectionViewLayout = layout
    }

    func fetchRecommends(uid: String) -> Task<Float, [User], Error> {
        return Task<Float, [User], Error> { _, fulfill, reject, _ in
        }
    }
}

// MARK: - IndicatorInfoProvider
extension MatchingRecommendationViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "候補")
    }
}

// MARK: - UICollectionViewDataSource
extension MatchingRecommendationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reusableCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendationCell", for: indexPath)
        guard let cell = reusableCell as? MatchingRecommendationCell else { return reusableCell }

        return cell
    }
}
