//
//  Classes.swift
//  OASIS
//
//  Created by 後藤誉昌 on 2016/11/05.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import Himotoki

struct Classes {

    let mon: String
    let tue: String
    let wed: String
    let thu: String
    let fri: String
}

extension Classes: Decodable {
    static func decode(_ e: Extractor) throws -> Classes {
        return try Classes(
            mon: e <| "mon",
            tue: e <| "tue",
            wed: e <| "wed",
            thu: e <| "thu",
            fri: e <| "fri"
        )
    }
}
