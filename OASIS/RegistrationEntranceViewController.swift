//
//  RegistrationEntranceViewController.swift
//  OASIS
//
//  Created by 後藤誉昌 on 2016/11/02.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import UIKit
import Firebase
import FacebookCore
import FacebookLogin

class RegistrationEntranceViewController: UIViewController, Storyboardable {

    // MARK: - Outlet

    // MARK: - Property
    private let storyboardName = "RegistrationEntrance"

    // MARK: - Lifecycle

    // MARK: - Action
    @IBAction private func loginBtnDidTap(_ sender: UIButton) {
        let loginManager = LoginManager()
        loginManager.logIn([.publicProfile], viewController: self) { loginResult in
            switch loginResult {
            case .success(_, _, let token):
                print("successfb")
                print(token.authenticationToken)
//                let credential = FIRFacebookAuthProvider.credential(withAccessToken: token.authenticationToken)
//                FIRAuth.auth()?.signIn(with: credential) { user, error in
//
//                }
            case .failed(let error):
                print("errorfb")
            case .cancelled:
                break
            }
        }
    }

    // MARK: - Public

    // MARK: - Private
}
