//
//  WebAPI.swift
//  OASIS
//
//  Created by 後藤誉昌 on 2016/11/05.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import Firebase

struct WebAPI {

    static let uuid: String {
        return FIRAuth.auth()?.currentUser?.uid
    }
}
