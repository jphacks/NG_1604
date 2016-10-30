//
//  AppError.swift
//  OASIS
//
//  Created by 後藤誉昌 on 2016/10/31.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import Foundation

enum AppError: Error {
    case connection
    case response
    case unauthorized
    case cancelled
    case unknown
}
