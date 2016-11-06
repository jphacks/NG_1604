//
//  RegistrationTimeTableViewController.swift
//  OASIS
//
//  Created by 後藤誉昌 on 2016/11/02.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import UIKit
import Firebase
import SwiftTask
import SVProgressHUD

class RegistrationTimeTableViewController: UIViewController, Storyboardable, ErrorHandlable {

    // MARK: - Outlets
    @IBOutlet private weak var collectionView: UICollectionView!

    // MARK: - Properties
    static let storyboardName = "RegistrationTimeTable"
    fileprivate let scheduler = ClassesScheduler()
    fileprivate let cellMargin: CGFloat = 6.0

    lazy var cellSize: CGSize = {
        let cellWidth: CGFloat = (self.collectionView.frame.size.width - self.cellMargin*4)/5
        return CGSize(width: cellWidth, height: cellWidth)
    }()

    var user: RegisteringUser!

    // MARK: - Action
    @IBAction private func submitBtnDidTap(_ sender: UIButton) {
        SVProgressHUD.show()

        user.classes = Classes(
            mon: scheduler.toCSV(on: .mon),
            tue: scheduler.toCSV(on: .tue),
            wed: scheduler.toCSV(on: .wed),
            thu: scheduler.toCSV(on: .thu),
            fri: scheduler.toCSV(on: .fri)
        )

        WebAPI.Users.create(user: user)
            .success { _ in
                SVProgressHUD.dismiss()
                SceneRouter.shared.route(scene: .main)
            }
            .failure { errorInfo in
                SVProgressHUD.dismiss()
                guard let error = errorInfo.error else { return }
                self.handle(error: error)
            }
    }
}

// MARK: - UICollectionViewDelegate
extension RegistrationTimeTableViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        scheduler.toggle(at: indexPath.row)
        collectionView.reloadItems(at: [indexPath])
    }
}

// MARK: - UICollectionViewDataSource
extension RegistrationTimeTableViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return scheduler.classes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let id = scheduler.get(at: indexPath.row) ? "SelectedCell" : "EmptyCell"
        return collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath)
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
