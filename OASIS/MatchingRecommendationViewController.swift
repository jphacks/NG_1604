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
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Property
    static let storyboardName = "MatchingRecommendation"

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {
        let layout = CarouselFlowLayout()
        layout.itemSize = collectionView.frame.size
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
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

// MARK: - UICollectionViewDataSource
extension MatchingRecommendationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendationCell", for: indexPath)
    }
}
