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

class RegistrationEntranceViewController: UIViewController, Storyboardable, ErrorHandlable {

    // MARK: - Property
    static let storyboardName = "RegistrationEntrance"

    // MARK: - Action
    @IBAction private func loginBtnDidTap(_ sender: UIButton) {
        let manager = LoginManager()
        manager.logIn([.publicProfile], viewController: self) { result in
            switch result {
            case .success(_, _, let token):
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: token.authenticationToken)
                FIRAuth.auth()?.signIn(with: credential) { user, error in
                    if let error = error {
                        self.handle(error: error)
                        return
                    }
                    self.navigationController?.pushViewController(RegistrationUserViewController.makeFromStoryboard(), animated: true)
                }
            case .failed(let error):
                self.handle(error: error)
            case .cancelled:
                break
            }
        }
    }
}
