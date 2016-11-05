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
    var schedule = ClassesScheduler() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    let cellMargin: CGFloat = 4.0
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

// MARK: - UICollectionViewDataSource
extension ScheduleView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return schedule.classes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reusableCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScheduleCell", for: indexPath)
        guard let cell = reusableCell as? ScheduleCell else { return reusableCell }
        cell.isFree = schedule.get(at: indexPath.row)
        return cell
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
