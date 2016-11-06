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
    typealias RoomTask = Task<Void, Room, Error>

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

    static func showRoom(id: String) -> RoomTask {
        return RoomTask { _, fulfill, reject, _ in
            let ref = FIRDatabase.database().reference().child("chatrooms").child(id)
            ref.observeSingleEvent(of: .value, with: { snapshot in
                guard let dic = snapshot.value as? [String : AnyObject],
                    let title = dic["title"] as? String,
                    let lastMessage = dic["lastMessage"] as? String else {
                        return
                }

                let room = Room(id: id, title: title, lastMessage: lastMessage)
                fulfill(room)
            }) { error in
                reject(error)
            }
        }
    }
}
