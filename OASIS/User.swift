//
//  User.swift
//  OASIS
//
//  Created by 後藤誉昌 on 2016/11/03.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import Himotoki

struct User {

    let uuid: String
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
            uuid: e <| ["user", "uuid"],
            name: e <| ["user", "name"],
            imageUrl: e <| ["user", "profile_img"],
            department: e <| ["user", "department"],
            gender: e <| ["user", "gender"],
            grade: e <| ["user", "grade"],
            profile: e <| ["user", "profile"],
            university: e <| ["user", "univ_name"],
            classes: e <| ["user", "classes"]
        )
    }
}
