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
    let ref = FIRDatabase.database().reference()

    // MARK: - Action
    @IBAction private func submitBtnDidTap(_ sender: UIButton) {
        guard let user = FIRAuth.auth()?.currentUser else { return }

        user.getTokenWithCompletion { (token, error) in
            guard let token = token else { return }
            self.fetchUserProfile(token: AccessToken(authenticationToken: token))
        }
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
                    let profile: FBProfile = try! decodeValue(responseDictionary) //エラー処理はちゃんとやろう。
                    dump(profile)
                    self.setProfile(profile: profile)
                }
            }
            
        }
    }

    private func setProfile(profile: FBProfile) {
        guard let user = FIRAuth.auth()?.currentUser else { return }

        // Firebase Realtime Databaseに突っ込む
        let data = ["name": profile.name, "univ": profile.education.last!.name, "gender": profile.gender]
        ref.child("users/\(user.uid)").setValue(data) { (error, ref) in
            if error != nil {
                print(error)
            } else {
                print("done!")
            }
        }

    }
}
