//
//  Mock.swift
//  OASIS
//
//  Created by 後藤誉昌 on 2016/11/05.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import Foundation
import JSQMessagesViewController

struct Mock {

    static let messages: [JSQMessage] = [
        JSQMessage(senderId: "user1", displayName: "ひでちゃん", text: "テスト"),
        JSQMessage(senderId: "user2", displayName: "ひでちゃん", text: "テスト"),
        JSQMessage(senderId: "user1", displayName: "ひでちゃん", text: "テスト"),
        JSQMessage(senderId: "user2", displayName: "ひでちゃん", text: "テスト"),
        JSQMessage(senderId: "user1", displayName: "ひでちゃん", text: "テスト"),
        JSQMessage(senderId: "user2", displayName: "ひでちゃん", text: "テスト")
    ]
}
