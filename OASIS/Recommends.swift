//
//  Recommends.swift
//  OASIS
//
//  Created by Yuto Yazaki on 2016/11/06.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import Himotoki

struct Recommends {
    let users: [User]
}

extension Recommends: Decodable {
    static func decode(_ e: Extractor) throws -> Recommends {
        return try Recommends(users: e <|| "recommends")
    }
}
