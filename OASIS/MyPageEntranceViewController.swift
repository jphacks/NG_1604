//
//  MyPageEntranceViewController.swift
//  OASIS
//
//  Created by 後藤誉昌 on 2016/11/02.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import UIKit
import Kingfisher

class MyPageEntranceViewController: UIViewController, Storyboardable, ErrorHandlable {

    // MARK: - Outlet
    @IBOutlet private weak var thumbView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var univLabel: UILabel!
    @IBOutlet private weak var profileLabel: UILabel!
    @IBOutlet private weak var scheduleView: ScheduleView!

    // MARK: - Property
    static let storyboardName = "MyPageEntrance"

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        WebAPI.Users.me()
            .success { user, _ in
                self.thumbView.kf.setImage(with: user.image)
                self.nameLabel.text = user.name
                self.profileLabel.text = user.profile

                let grade = Grade.cases[user.grade-1]
                self.univLabel.text = "\(user.university) \(user.department) \(grade.rawValue)"
            }
            .failure { errorInfo in
                guard let error = errorInfo.error else { return }
                self.handle(error: error)
            }
    }

    // MARK: - Action
    @IBAction private func editBtnDidTap(_ sender: UIButton) {
        let next = MyPageEditViewController.makeFromStoryboard()
        next.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(next, animated: true)
    }
}
