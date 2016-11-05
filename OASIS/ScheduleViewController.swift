//
//  ScheduleViewController.swift
//  OASIS
//
//  Created by Yuto Yazaki on 2016/11/05.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController, Storyboardable {

    // MARK: - Outlets
    @IBOutlet weak private var collectionView: UICollectionView!

    // MARK: - Properties
    static let storyboardName = "ScheduleViewController"
    var schedule = ClassSchedule()

    fileprivate let cellMargin: CGFloat = 6.0
    fileprivate lazy var cellSize: CGSize = {
        let cellWidth: CGFloat = (self.collectionView.frame.size.width - self.cellMargin*4)/5
        return CGSize(width: cellWidth, height: cellWidth)
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
    }

    // MARK: - Public
    func setSchedule(schedule: ClassSchedule) {
        self.schedule = schedule
    }
}

// MARK: - UICollectionViewDelegate
extension ScheduleViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        schedule.toggle(at: indexPath.row)
        collectionView.reloadItems(at: [indexPath])
    }
}

// MARK: - UICollectionViewDataSource
extension ScheduleViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return schedule.classes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if schedule.get(at: indexPath.row) {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedCell", for: indexPath)
        } else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyCell", for: indexPath)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ScheduleViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellMargin
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellMargin
    }
}
