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
//        guard let user = FIRAuth.auth()?.currentUser else { return }
//
//        getToken(user: user)
//            .success { token -> Task<Float, FBProfile, Error> in
//                return self.fetchUserProfile(token: token)
//            }
//            .success { profile -> Task<Float, Void, Error> in
//                return self.setProfile(profile: profile)
//            }
//            .success { result -> () in
//                let next = RegistrationTimeTableViewController.makeFromStoryboard()
//                self.navigationController?.pushViewController(next, animated: true)
//                return
//            }
    }

    // MARK: - Private

    private func setProfile(profile: FBProfile) -> Task<Float, Void, Error> {
        return Task<Float, Void, Error> { _, fulfill, reject, _ in
            guard let user = FIRAuth.auth()?.currentUser else {
                reject(AppError.unauthorized)
                return
            }

            let data = [
                "name": profile.name,
                "univ": profile.education.last!.name,
                "gender": profile.gender,
                "profile_img": profile.profileImage,
                "department": profile.education.last?.concentration?.last?.name ?? ""
            ]

            self.ref.child("users/\(user.uid)").setValue(data) { error, ref in
                if let error = error {
                    reject(error)
                } else {
                    fulfill()
                }
            }
        }
    }
}
