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
import SwiftTask
import Himotoki

class RegistrationEntranceViewController: UIViewController, Storyboardable, ErrorHandlable {

    // MARK: - Property
    static let storyboardName = "RegistrationEntrance"

    // MARK: - Action
    @IBAction private func loginBtnDidTap(_ sender: UIButton) {
        let manager = LoginManager()
        manager.logIn([.publicProfile, .custom("user_education_history")], viewController: self) { [weak self] result in
            switch result {
            case .success(_, _, let token):
                self?.signIn(token: token)
            case .failed(let error):
                self?.handle(error: error)
            case .cancelled:
                break
            }
        }
    }

    // MARK: - Private
    func signIn(token: AccessToken) {
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: token.authenticationToken)
        FIRAuth.auth()?.signIn(with: credential) { user, error in
            if let error = error {
                self.handle(error: error)
            } else if let user = user {
                self.getToken(user: user)
                    .success { token -> Task<Float, FBProfile, Error> in
                        return self.fetchUserProfile(token: token)
                    }
                    .success { profile in
                        let next = RegistrationUserViewController.makeFromStoryboard()
                        next.fbProfile = profile
                        self.navigationController?.pushViewController(next, animated: true)
                    }
            }
        }
    }

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
}
