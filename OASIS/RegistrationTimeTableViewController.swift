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

class RegistrationTimeTableViewController: UIViewController, Storyboardable {

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Properties
    static let storyboardName = "RegistrationTimeTable"

    let cellMargin: CGFloat = 6.0

    lazy var cellSize: CGSize = {
        let cellWidth: CGFloat = (self.collectionView.frame.size.width - self.cellMargin*4)/5
        return CGSize(width: cellWidth, height: cellWidth)
    }()

    let schedule = ClassSchedule()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
    }

    // MARK: - Action
    @IBAction private func submitBtnDidTap(_ sender: UIButton) {
        guard let _ = FIRAuth.auth()?.currentUser else { return }

        // コレクションビューで選択した空きコマをFirebaseに保存
        updateSchedule().success { value -> () in
            print(value)
            SceneRouter.shared.route(scene: .main)
        }.failure { error, _ in
            print(error)
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
                "mon": self.schedule.toCSV(on: .mon),
                "tue": self.schedule.toCSV(on: .tue),
                "wed": self.schedule.toCSV(on: .wed),
                "thu": self.schedule.toCSV(on: .thu),
                "fri": self.schedule.toCSV(on: .fri)
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
        schedule.toggle(at: indexPath.row)
        collectionView.reloadItems(at: [indexPath])
    }
}

// MARK: - UICollectionViewDataSource
extension RegistrationTimeTableViewController: UICollectionViewDataSource {
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
