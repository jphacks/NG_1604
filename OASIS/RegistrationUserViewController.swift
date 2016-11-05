//
//  RegistrationUserViewController.swift
//  OASIS
//
//  Created by 後藤誉昌 on 2016/11/02.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import UIKit
import Firebase
import FacebookCore
import Himotoki
import SwiftTask
import Kingfisher

class RegistrationUserViewController: UIViewController, Storyboardable, ErrorHandlable {

    // MARK: - Outlet
    @IBOutlet private weak var thumbView: UIImageView!

    // MARK: - Property
    static let storyboardName = "RegistrationUser"
    private var formViewController: RegistrationUserFormViewController!
    private var user = RegisteringUser()

    var fbProfile: FBProfile!

    // MARK: - Lifecycle
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let vc as RegistrationUserFormViewController:
            formViewController = vc
            formViewController.fbProfile = fbProfile
        default:
            break
        }
    }

    override func viewDidLoad() {
        thumbView.kf.setImage(with: fbProfile.image)
    }

    // MARK: - Action
    @IBAction private func submitBtnDidTap(_ sender: UIButton) {
        user.image = fbProfile.profileImage
        user.name = formViewController.name
        user.gender = fbProfile.gender
        user.univ = formViewController.univ
        user.department = formViewController.department
        user.grade = formViewController.grade.id
        user.profile = formViewController.profile

        let next = RegistrationTimeTableViewController.makeFromStoryboard()
        next.user = user
        self.navigationController?.pushViewController(next, animated: true)
    }
}
