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
        guard let _ = FIRAuth.auth()?.currentUser else { return }

        updateSchedule().success { value -> () in
            SceneRouter.shared.route(scene: .main)
        }.failure { errorInfo in
            guard let error = errorInfo.error else { return }
            self.handle(error: error)
        }
    }

    // MARK: - Private
    private func updateSchedule() -> Task<Float, Void, Error> {
        return Task<Float, Void, Error> { _, fulfill, reject, _ in
            let ref = FIRDatabase.database().reference()

            guard let user = FIRAuth.auth()?.currentUser else {
                reject(AppError.unauthorized)
                return
            }

            let data = [
                "mon": self.scheduler.toCSV(on: .mon),
                "tue": self.scheduler.toCSV(on: .tue),
                "wed": self.scheduler.toCSV(on: .wed),
                "thu": self.scheduler.toCSV(on: .thu),
                "fri": self.scheduler.toCSV(on: .fri)
            ]

            ref.child("users/\(user.uid)/classes").setValue(data) { error, ref in
                if let error = error {
                    reject(error)
                } else {
                    fulfill()
                }
            }
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
        if scheduler.get(at: indexPath.row) {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedCell", for: indexPath)
        } else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyCell", for: indexPath)
        }
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
