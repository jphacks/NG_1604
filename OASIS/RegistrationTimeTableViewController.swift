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
    let emptyCellIdentifier = "EmptyCell"
    let selectedCellIdentifier = "SelectedCell"
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

        updateSchedule().success { value -> Void in
            print(value)
            SceneRouter.shared.route(scene: .main)
        }.failure { error, _ in
            print(error)
        }
    }

    // MARK: - Private
    private func updateSchedule() -> Task<Float, String, Error?> {
        return Task<Float, String, Error?> { _, fulfill, reject, _ in
            let ref = FIRDatabase.database().reference()

            guard let user = FIRAuth.auth()?.currentUser else {
                reject(nil)
                return
            }

            let data = ["mon": self.schedule.toCSV(on: .mon),
                        "tue": self.schedule.toCSV(on: .tue),
                        "wed": self.schedule.toCSV(on: .wed),
                        "thu": self.schedule.toCSV(on: .thu),
                        "fri": self.schedule.toCSV(on: .fri)]
            dump(data)

            ref.child("users/\(user.uid)/classes").setValue(data) { (error, ref) in
                if error != nil {
                    reject(error)
                    print(error)
                } else {
                    fulfill("done!")
                }
            }

        }
    }
}

// MARK: - UICollectionViewDelegate
extension RegistrationTimeTableViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
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
        var cell: UICollectionViewCell

        switch (schedule.get(at: indexPath.row)) {
        case true:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: selectedCellIdentifier, for: indexPath)
            break
        case false:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: emptyCellIdentifier, for: indexPath)
            break
        }

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
