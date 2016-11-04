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

    static func decode(_ e: Extractor) throws -> FBProfile {
        return try FBProfile(name: e <| "name", gender: e <| "gender", id: e <| "id", profileImage: e <| ["picture","data","url"], education: e <|| "education")
    }
}

struct FBSchool: Decodable {
    let name: String
    let type: String
    let concentration: [FBDepartment]?

    static func decode(_ e: Extractor) throws -> FBSchool {
        return try FBSchool(name: e <| ["school","name"], type: e <| "type", concentration: e <||? "concentration")
    }
}

struct FBDepartment: Decodable {
    let name: String

    static func decode(_ e: Extractor) throws -> FBDepartment {
        return try FBDepartment(name: e <| "name")
    }
}
