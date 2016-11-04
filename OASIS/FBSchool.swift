//
//  FBSchool.swift
//  OASIS
//
//  Created by 後藤誉昌 on 2016/11/05.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import Himotoki

struct FBSchool: Decodable {
    let name: String
    let type: String
    let concentration: [FBDepartment]?

    static func decode(_ e: Extractor) throws -> FBSchool {
        return try FBSchool(
            name: e <| ["school", "name"],
            type: e <| "type",
            concentration: e <||? "concentration"
        )
    }
}
