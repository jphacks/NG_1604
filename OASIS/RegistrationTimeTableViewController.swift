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

    // MARK: - Property
    static let storyboardName = "RegistrationTimeTable"

    // MARK: - Action
    @IBAction private func submitBtnDidTap(_ sender: UIButton) {
        guard let _ = FIRAuth.auth()?.currentUser else { return }

        SceneRouter.shared.route(scene: .main)
    }
}
