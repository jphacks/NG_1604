//
//  RegistrationUserViewController.swift
//  OASIS
//
//  Created by 後藤誉昌 on 2016/11/02.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import UIKit
import Firebase

class RegistrationUserViewController: UIViewController, Storyboardable, ErrorHandlable {

    // MARK: - Property
    static let storyboardName = "RegistrationUser"

    // MARK: - Action
    @IBAction private func submitBtnDidTap(_ sender: UIButton) {
        guard let user = FIRAuth.auth()?.currentUser else { return }

        let request = user.profileChangeRequest()
        request.displayName = "ヒデちゃん"
        request.photoURL = URL(string: "http://www.othlo.tech/images/members/hide.png")
        request.commitChanges { error in
            if let error = error {
                self.handle(error: error)
            } else {
                let next = RegistrationTimeTableViewController.makeFromStoryboard()
                self.navigationController?.pushViewController(next, animated: true)
            }
        }
    }
}
