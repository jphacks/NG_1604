//
//  RegistrationEntranceViewController.swift
//  OASIS
//
//  Created by 後藤誉昌 on 2016/11/02.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import UIKit

class RegistrationEntranceViewController: UIViewController, Storyboardable, ErrorHandlable {

    // MARK: - Property
    static let storyboardName = "RegistrationEntrance"

    // MARK: - Action
    @IBAction private func loginBtnDidTap(_ sender: UIButton) {
        Facebook.requestAuth(viewController: self)
            .success { token -> Firebase.UserTask in
                return Firebase.signIn(token: token)
            }
            .success { user -> Firebase.TokenTask in
                return Firebase.token(user: user)
            }
            .success { token -> Facebook.ProfileTask in
                return Facebook.userProfile(token: token)
            }
            .success { profile in
                let next = RegistrationUserViewController.makeFromStoryboard()
                next.fbProfile = profile
                self.navigationController?.pushViewController(next, animated: true)
            }
            .failure { errorInfo in
                guard let error = errorInfo.error else { return }
                self.handle(error: error)
            }
    }
}
