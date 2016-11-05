//
//  WebAPI.Users.swift
//  OASIS
//
//  Created by 後藤誉昌 on 2016/11/05.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import SwiftTask
import Alamofire
import Himotoki

extension WebAPI {

    struct Users {

        typealias VoidTask = Task<Void, Void, Error>
        typealias UserTask = Task<Void, User, Error>

        static func create(image: String, name: String, gender: String, univ: String, department: String, grade: Int, profile: String) -> VoidTask {
            return VoidTask { _, fulfill, reject, _ in
                guard let uuid = WebAPI.uuid else {
                    reject(AppError.unauthorized)
                    return
                }

                let url = AppConfig.WebAPI.BaseURL + "/users"

                let params: Parameters = [
                    "uuid": uuid,
                    "department": department,
                    "gender": gender,
                    "name": name,
                    "grade": grade,
                    "profile": profile,
                    "profile_img": image,
                    "univ_name": univ
                ]

                Alamofire.request(url, method: .post, parameters: params)
                    .responseJSON { response in
                        if let error = response.result.error {
                            reject(error)
                        }

                        fulfill(())
                }
            }
        }

        static func update(uuid: String) -> VoidTask {
            return VoidTask { _, fulfill, reject, _ in
                let url = AppConfig.WebAPI.BaseURL + "/users/" + uuid

                Alamofire.request(url, method: .post)
                    .responseJSON { response in
                        if let error = response.result.error {
                            reject(error)
                        }

                        fulfill(())
                }
            }
        }

        static func show(uuid: String) -> UserTask {
            return UserTask { _, fulfill, reject, _ in
                let url = AppConfig.WebAPI.BaseURL + "/users/" + uuid

                Alamofire.request(url)
                    .responseJSON { response in
                        if let error = response.result.error {
                            reject(error)
                        }

                        if let json = response.result.value as? [String: String], let user = try? User.decodeValue(json) {
                            fulfill(user)
                        }

                        reject(AppError.unknown)
                }
            }
        }

        static func remove() -> VoidTask {
            return VoidTask { _, fulfill, reject, _ in
                guard let uuid = WebAPI.uuid else {
                    reject(AppError.unauthorized)
                    return
                }

                let url = AppConfig.WebAPI.BaseURL + "/users/" + uuid + "/remove"

                Alamofire.request(url, method: .post)
                    .responseJSON { response in
                        if let error = response.result.error {
                            reject(error)
                        }

                        fulfill(())
                }
            }
        }

        static func like(opponent: String) -> VoidTask {
            return VoidTask { _, fulfill, reject, _ in
                guard let uuid = WebAPI.uuid else {
                    reject(AppError.unauthorized)
                    return
                }

                let url = AppConfig.WebAPI.BaseURL + "/users/" + uuid + "/like"

                let params: Parameters = [
                    "opponent_uuid": opponent,
                    "match_result": true
                ]

                Alamofire.request(url, method: .post, parameters: params)
                    .responseJSON { response in
                        if let error = response.result.error {
                            reject(error)
                        }

                        fulfill(())
                }
            }
        }

        static func dislike(opponent: String) -> VoidTask {
            return VoidTask { _, fulfill, reject, _ in
                guard let uuid = WebAPI.uuid else {
                    reject(AppError.unauthorized)
                    return
                }

                let url = AppConfig.WebAPI.BaseURL + "/users/" + uuid + "/like"

                let params: Parameters = [
                    "opponent_uuid": opponent,
                    "match_result": false
                ]

                Alamofire.request(url, method: .post, parameters: params)
                    .responseJSON { response in
                        if let error = response.result.error {
                            reject(error)
                        }

                        fulfill(())
                }
            }
        }
    }
}
