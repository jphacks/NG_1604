//
//  MyPageEntranceViewController.swift
//  OASIS
//
//  Created by 後藤誉昌 on 2016/11/02.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import UIKit
import Kingfisher
import Firebase

class MyPageEntranceViewController: UIViewController, Storyboardable, ErrorHandlable {

    // MARK: - Outlet
    @IBOutlet private weak var thumbView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var univLabel: UILabel!
    @IBOutlet private weak var profileLabel: UILabel!
    @IBOutlet private weak var scheduleView: ScheduleView!

    // MARK: - Property
    static let storyboardName = "MyPageEntrance"
    let ref = FIRDatabase.database().reference()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if let uuid = WebAPI.uuid {
            self.ref.child("/users/\(uuid)").observeSingleEvent(of: .value, with: { snapshot in
                if let data = snapshot.value as? [String: Any] {
                    // swiftlint:disable force_cast
                    self.nameLabel.text = data["name"] as? String
                    let univ = data["univ_name"] as! String
                    let department = data["department"] as! String
                    self.univLabel.text = "\(univ) \(department)"
                    self.profileLabel.text = data["profile"] as? String
                    let profile_img = data["profile_img"] as? String
                    self.thumbView.kf.setImage(with: URL(string: profile_img!))
                }
            })
        }
    }

    // MARK: - Action
    @IBAction private func editBtnDidTap(_ sender: UIButton) {
        let next = MyPageEditViewController.makeFromStoryboard()
        next.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(next, animated: true)
    }
}
