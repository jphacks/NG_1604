//
//  RegistrationTimeTableViewController.swift
//  OASIS
//
//  Created by 後藤誉昌 on 2016/11/02.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import UIKit
import Firebase

class RegistrationTimeTableViewController: UIViewController, Storyboardable {

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Properties
    static let storyboardName = "RegistrationTimeTable"
    let emptyCellIdentifier = "EmptyCell"
    let cellMargin: CGFloat = 6.0
    lazy var cellSize: CGSize = {
        let cellWidth: CGFloat = (self.collectionView.frame.size.width - self.cellMargin*4)/5
        return CGSize(width: cellWidth, height: cellWidth)
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
    }

    // MARK: - Action
    @IBAction private func submitBtnDidTap(_ sender: UIButton) {
        guard let _ = FIRAuth.auth()?.currentUser else { return }

        SceneRouter.shared.route(scene: .main)
    }
}

// MARK: - UICollectionViewDelegate
extension RegistrationTimeTableViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }

        if cell.reuseIdentifier == emptyCellIdentifier {

        } else {

        }

        collectionView.reloadItems(at: [indexPath])
    }
}

// MARK: - UICollectionViewDataSource
extension RegistrationTimeTableViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: emptyCellIdentifier, for: indexPath)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension RegistrationTimeTableViewController: UICollectionViewDelegateFlowLayout {

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
