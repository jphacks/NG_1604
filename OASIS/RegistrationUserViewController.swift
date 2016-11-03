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

class RegistrationUserViewController: UIViewController, Storyboardable, ErrorHandlable {

    // MARK: - Property
    static let storyboardName = "RegistrationUser"

    // MARK: - Action
    @IBAction private func submitBtnDidTap(_ sender: UIButton) {
        guard let user = FIRAuth.auth()?.currentUser else { return }

        user.getTokenWithCompletion { (token, error) in
            guard let token = token else { return }
            self.fetchUserProfile(token: AccessToken(authenticationToken: token))
        }
//        let request = user.profileChangeRequest()
//        request.displayName = "ヒデちゃん"
//        request.photoURL = URL(string: "http://www.othlo.tech/images/members/hide.png")
//        request.commitChanges { error in
//            if let error = error {
//                self.handle(error: error)
//            } else {
//                let next = RegistrationTimeTableViewController.makeFromStoryboard()
//                self.navigationController?.pushViewController(next, animated: true)
//            }
//        }
    }

    // MARK: - Private
    private func fetchUserProfile(token: AccessToken) {
        let params: [String: Any] = ["fields":"email,name,picture.width(1000).height(1000),gender,education", "locale": "ja_JP"]
        let graphRequest = GraphRequest(graphPath: "me", parameters: params, accessToken: token, httpMethod: .GET, apiVersion: .defaultVersion)

        // Facebook Graph APIからプロフィールを取得
        graphRequest.start { (urlResponse, requestResult) in
            switch requestResult {
            case .failed(let error):
                print("error in graph request:", error)
                break
            case .success(let graphResponse):
                if let responseDictionary = graphResponse.dictionaryValue {
                    let profile: FBProfile = try! decodeValue(responseDictionary)
                    dump(profile)
                }
            }
            
        }
    }
}
