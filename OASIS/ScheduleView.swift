//
//  ScheduleView.swift
//  OASIS
//
//  Created by Yuto Yazaki on 2016/11/05.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import UIKit

class ScheduleView: UIView {

    // MARK: - Outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Properties
    let schedule = ClassesScheduler()
    let cellMargin: CGFloat = 6.0
    lazy var cellSize: CGSize = {
        let cellWidth: CGFloat = (self.collectionView.frame.size.width - self.cellMargin*4)/5
        return CGSize(width: cellWidth, height: cellWidth)
    }()

    // MARK: - Lifecycle
    override func awakeFromNib() {
        contentView = Bundle.main.loadNibNamed("ScheduleView", owner: self, options: nil)!.first! as? UIView // swiftlint:disable:this force_cast
        contentView.frame = frame
        addSubview(contentView)

        let nib = UINib(nibName: "ScheduleCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "ScheduleCell")
    }
}

// MARK: - UICollectionViewDelegate
extension ScheduleView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        schedule.toggle(at: indexPath.row)
        collectionView.reloadItems(at: [indexPath])
    }
}

// MARK: - UICollectionViewDataSource
extension ScheduleView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return schedule.classes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "ScheduleCell", for: indexPath)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ScheduleView: UICollectionViewDelegateFlowLayout {

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
