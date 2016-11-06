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
import Firebase

class MatchingRecommendationViewController: UIViewController, Storyboardable {

    // MARK: - Outlet
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Property
    static let storyboardName = "MatchingRecommendation"
    var recommends: [User] = []
    let ref = FIRDatabase.database().reference()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        WebAPI.Users.show(uuid: "123456789")
            .success { _, recommends -> Void in
                self.recommends = recommends.users
                self.collectionView.reloadData()
                if let uuid = WebAPI.uuid {
                    self.ref.child("/users/\(uuid)/matches").observe(.childAdded, with: { snapshot in
                        dump(snapshot.value)
                    })
                }
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
        layout.itemSize = CGSize(width: self.collectionView.frame.size.width-40, height: self.collectionView.frame.size.height)
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
        return recommends.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reusableCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendationCell", for: indexPath)
        guard let cell = reusableCell as? MatchingRecommendationCell else { return reusableCell }
        cell.user = recommends[indexPath.row]
        cell.delegate = self
        return cell
    }
}

// MARK: - MatchingRecommendationDelegate
extension MatchingRecommendationViewController: MatchingRecommendationDelegate {
    func deleteCell() {
        let point = CGPoint(x: collectionView.frame.midX, y: collectionView.frame.midY)
        if let indexPath = collectionView.indexPathForItem(at: point) {
            recommends.remove(at: indexPath.row)
            collectionView.deleteItems(at: [indexPath])
        }
    }
}
