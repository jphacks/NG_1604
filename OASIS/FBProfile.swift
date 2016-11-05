//
//  FBProfile.swift
//  OASIS
//
//  Created by Yuto Yazaki on 2016/11/03.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import Himotoki

struct FBProfile: Decodable {
    let name: String
    let gender: String
    let id: String
    let profileImage: String
    let education: [FBSchool]

    var image: URL? {
        return URL(string: profileImage)
    }

    static func decode(_ e: Extractor) throws -> FBProfile {
        return try FBProfile(
            name: e <| "name",
            gender: e <| "gender",
            id: e <| "id",
            profileImage: e <| ["picture", "data", "url"],
            education: e <|| "education"
        )
    }
}
