//
//  MyPageEditViewController.swift
//  OASIS
//
//  Created by 後藤誉昌 on 2016/11/02.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import UIKit
import Firebase

class MyPageEditViewController: UIViewController, Storyboardable, ErrorHandlable {

    // MARK: - Outlet

    // MARK: - Property
    static let storyboardName = "MyPageEdit"

    // MARK: - Lifecycle

    // MARK: - Action
    @IBAction private func signOutBtnDidTap(_ sender: UIButton) {
        do {
            try FIRAuth.auth()?.signOut()
            SceneRouter.shared.route(scene: .registration)
        } catch let error {
            handle(error: error)
        }
    }

    // MARK: - Public

    // MARK: - Private
}
