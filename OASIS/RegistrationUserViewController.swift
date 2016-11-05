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
    private let ref = FIRDatabase.database().reference()
    private var formViewController: RegistrationUserFormViewController!

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
        let user = RegisteringUser(
            image: fbProfile.profileImage,
            name: formViewController.name,
            gender: fbProfile.gender,
            univ: formViewController.univ,
            department: formViewController.department,
            grade: formViewController.grade.id,
            profile: formViewController.profile
        )
        
        let next = RegistrationTimeTableViewController.makeFromStoryboard()
        next.user = user
        self.navigationController?.pushViewController(next, animated: true)
    }
}
