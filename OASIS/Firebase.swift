//
//  Firebase.swift
//  OASIS
//
//  Created by 後藤誉昌 on 2016/11/06.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import SwiftTask
import Firebase
import FacebookCore
import FacebookLogin

struct Firebase {

    typealias UserTask = Task<Void, FIRUser, Error>
    typealias TokenTask = Task<Void, AccessToken, Error>

    static func signIn(token: String) -> UserTask {
        return UserTask { _, fulfill, reject, _ in
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: token)
            FIRAuth.auth()?.signIn(with: credential) { user, error in
                if let user = user {
                    fulfill(user)
                }

                if let error = error {
                    reject(error)
                }

                reject(AppError.unknown)
            }
        }
    }

    static func token(user: FIRUser) -> TokenTask {
        return TokenTask { _, fulfill, reject, _ in
            user.getTokenWithCompletion { token, error in
                if let token = token {
                    fulfill(AccessToken(authenticationToken: token))
                }

                if let error = error {
                    reject(error)
                }

                reject(AppError.unknown)
            }
        }
    }
}
