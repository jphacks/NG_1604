//
//  ChatRoomViewController.swift
//  OASIS
//
//  Created by 後藤誉昌 on 2016/11/02.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class ChatRoomViewController: JSQMessagesViewController, Storyboardable {

    // MARK: - Outlet

    // MARK: - Property
    static let storyboardName = "ChatRoom"

    var messages: [JSQMessage]?
    var incomingBubble: JSQMessagesBubbleImage!
    var outgoingBubble: JSQMessagesBubbleImage!
    var incomingAvatar: JSQMessagesAvatarImage!
    var outgoingAvatar: JSQMessagesAvatarImage!

    var room: Room? {
        didSet {

        }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        //自分のsenderId, senderDisokayNameを設定
        self.senderId = "user1"
        self.senderDisplayName = "hoge"

        //吹き出しの設定
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        self.incomingBubble = bubbleFactory?.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
        self.outgoingBubble = bubbleFactory?.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())

        //アバターの設定
//        self.incomingAvatar = JSQMessagesAvatarImageFactory.avatarImage(with: UIImage(named: "Swift-Logo")!, diameter: 64)
//        self.outgoingAvatar = JSQMessagesAvatarImageFactory.avatarImage(with: UIImage(named: "Swift-Logo")!, diameter: 64)

        //メッセージデータの配列を初期化
        self.messages = [
            JSQMessage(senderId: "user1", displayName: "Hoge", text: "test"),
            JSQMessage(senderId: "user1", displayName: "Hoge", text: "test"),
            JSQMessage(senderId: "user1", displayName: "Hoge", text: "test"),
            JSQMessage(senderId: "user1", displayName: "Hoge", text: "test"),
            JSQMessage(senderId: "user1", displayName: "Hoge", text: "test"),
            JSQMessage(senderId: "user1", displayName: "Hoge", text: "test"),
            JSQMessage(senderId: "user1", displayName: "Hoge", text: "test"),
            JSQMessage(senderId: "user1", displayName: "Hoge", text: "test"),
            JSQMessage(senderId: "user1", displayName: "Hoge", text: "test")
        ]
    }

    // MARK: - Action

    // MARK: - Public
    func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {

        //メッセジの送信処理を完了する(画面上にメッセージが表示される)
        self.finishReceivingMessage(animated: true)

    }

    //アイテムごとに参照するメッセージデータを返す
    func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        return self.messages?[indexPath.item]
    }

    //アイテムごとのMessageBubble(背景)を返す
    func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = self.messages?[indexPath.item]
        if message?.senderId == self.senderId {
            return self.outgoingBubble
        }
        return self.incomingBubble
    }

    //アイテムごとにアバター画像を返す
    func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        let message = self.messages?[indexPath.item]
        if message?.senderId == self.senderId {
            return self.outgoingAvatar
        }
        return self.incomingAvatar
    }

    //アイテムの総数を返す
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.messages?.count)!
    }

    // MARK: - Private
}
