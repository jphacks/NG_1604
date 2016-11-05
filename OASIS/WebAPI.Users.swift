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

        typealias UserTask = Task<Void, User, Error>

        static func create(image: String, name: String, gender: String, univ: String, department: String, grade: Int, profile: String) -> UserTask {
            return UserTask { _, fulfill, reject, _ in
                let url = AppConfig.WebAPI.BaseURL + "/users"

                let params: Parameters = [
                    "uuid": "test",
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

                        if let json = response.result.value as? [String: String], let user = try? User.decodeValue(json) {
                            fulfill(user)
                        }

                        reject(AppError.unknown)
                }
            }
        }
    }
}
