//
//  Facebook.swift
//  OASIS
//
//  Created by 後藤誉昌 on 2016/11/06.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import SwiftTask
import FacebookCore
import FacebookLogin
import Himotoki

struct Facebook {

    typealias StringTask = Task<Void, String, Error>
    typealias ProfileTask = Task<Void, FBProfile, Error>

    static func requestAuth(viewController: UIViewController) -> StringTask {
        return StringTask { _, fulfill, reject, _ in
            let manager = LoginManager()

            manager.logIn([.publicProfile, .custom("user_education_history")], viewController: viewController) { result in
                switch result {
                case .success(_, _, let token):
                    fulfill(token.authenticationToken)
                case .failed(let error):
                    reject(error)
                case .cancelled:
                    reject(AppError.cancelled)
                }
            }
        }
    }

    static func userProfile(token: AccessToken) -> ProfileTask {
        return ProfileTask { _, fulfill, reject, _ in
            let params: [String: Any] = [
                "fields": "email,name,picture.width(300).height(300),gender,education",
                "locale": "ja_JP"
            ]

            let graphRequest = GraphRequest(graphPath: "me", parameters: params, accessToken: token, httpMethod: .GET, apiVersion: .defaultVersion)

            graphRequest.start { _, requestResult in
                switch requestResult {
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
                case .failed(let error):
                    reject(error)
                }
            }
        }
    }
}
