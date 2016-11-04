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

    static let me = User(name: "ひでちゃん", image: URL(string: "http://www.othlo.tech/images/members/hide.png")!)
    static let other = User(name: "やざきちゃん", image: URL(string: "http://www.othlo.tech/images/members/yazaki.jpg")!)

    static let room1 = Room(user: other, messages: [
        Message(user: other, comment: "テスト1", date: Date()),
        Message(user: me, comment: "テスト2", date: Date()),
        Message(user: other, comment: "テスト3", date: Date()),
        Message(user: me, comment: "テスト4", date: Date()),
        Message(user: other, comment: "テスト5", date: Date()),
        Message(user: me, comment: "テスト6", date: Date())
    ])

    static let rooms = [room1, room1, room1]

    static let messages: [JSQMessage] = [
        JSQMessage(senderId: "user1", displayName: "ひでちゃん", text: "テスト"),
        JSQMessage(senderId: "user2", displayName: "ひでちゃん", text: "テスト"),
        JSQMessage(senderId: "user1", displayName: "ひでちゃん", text: "テスト"),
        JSQMessage(senderId: "user2", displayName: "ひでちゃん", text: "テスト"),
        JSQMessage(senderId: "user1", displayName: "ひでちゃん", text: "テスト"),
        JSQMessage(senderId: "user2", displayName: "ひでちゃん", text: "テスト")
    ]
}
