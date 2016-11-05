//
//  User.swift
//  OASIS
//
//  Created by 後藤誉昌 on 2016/11/03.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import Himotoki

struct User {

    let name: String
    let imageUrl: String
    let department: String
    let gender: String
    let grade: Int
    let profile: String
    let university: String
    let classes: Classes

    var image: URL? {
        return URL(string: imageUrl)
    }
}

extension User: Decodable {
    static func decode(_ e: Extractor) throws -> User {
        return try User(
            name: e <| "name",
            imageUrl: e <| "profile_img",
            department: e <| "department",
            gender: e <| "date",
            grade: e <| "medium",
            profile: e <| "profile",
            university: e <| "univ_name",
            classes: e <| "classes"
        )
    }
}
