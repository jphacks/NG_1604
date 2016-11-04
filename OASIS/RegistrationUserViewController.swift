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

class RegistrationUserViewController: UIViewController, Storyboardable, ErrorHandlable {

    // MARK: - Property
    static let storyboardName = "RegistrationUser"
    let ref = FIRDatabase.database().reference()

    // MARK: - Action
    @IBAction private func submitBtnDidTap(_ sender: UIButton) {
        guard let user = FIRAuth.auth()?.currentUser else { return }

        getToken(user: user)
            .success { token -> Task<Float, FBProfile, Error> in
                return self.fetchUserProfile(token: token)
            }
            .success { profile -> Task<Float, Void, Error> in
                return self.setProfile(profile: profile)
            }
            .success { result -> () in
                return
            }
    }

    // MARK: - Private
    private func getToken(user: FIRUser) -> Task<Float, AccessToken, Error> {
        return Task<Float, AccessToken, Error> { _, fulfill, reject, _ in
            user.getTokenWithCompletion { token, error in
                if let error = error {
                    reject(error)
                } else if let token = token {
                    fulfill(AccessToken(authenticationToken: token))
                }
            }
        }
    }

    // Facebook Graph APIからプロフィールを取得
    private func fetchUserProfile(token: AccessToken) -> Task<Float, FBProfile, Error> {
        return Task<Float, FBProfile, Error> { _, fulfill, reject, _ in
            let params: [String: Any] = [
                "fields": "email,name,picture.width(300).height(300),gender,education",
                "locale": "ja_JP"
            ]
            let graphRequest = GraphRequest(graphPath: "me", parameters: params, accessToken: token, httpMethod: .GET, apiVersion: .defaultVersion)

            graphRequest.start { urlResponse, requestResult in
                switch requestResult {
                case .failed(let error):
                    reject(error)
                case .success(let graphResponse):
                    guard let response = graphResponse.dictionaryValue else {
                        reject(AppError.unknown)
                        return
                    }

                    do {
                        fulfill(try decodeValue(response))
                    } catch let error {
                        reject(error)
                    }
                }
            }
        }
    }

    // Firebase Realtime Databaseに突っ込む
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
