//
//  FBDepartment.swift
//  OASIS
//
//  Created by 後藤誉昌 on 2016/11/05.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import Himotoki

struct FBDepartment: Decodable {
    let name: String

    static func decode(_ e: Extractor) throws -> FBDepartment {
        return try FBDepartment(
            name: e <| "name"
        )
    }
}
