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

    // MARK: - Property
    static let storyboardName = "ChatRoom"

    var messages = Mock.messages

    var incomingBubble: JSQMessagesBubbleImage!
    var outgoingBubble: JSQMessagesBubbleImage!
    var incomingAvatar: JSQMessagesAvatarImage!
    var outgoingAvatar: JSQMessagesAvatarImage!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        inputToolbar!.contentView!.leftBarButtonItem = nil
        automaticallyScrollsToMostRecentMessage = true

        senderId = "user1"
        senderDisplayName = "ひでちゃん"

        let bubbleFactory = JSQMessagesBubbleImageFactory()
        incomingBubble = bubbleFactory?.incomingMessagesBubbleImage(with: .jsq_messageBubbleLightGray())
        outgoingBubble = bubbleFactory?.outgoingMessagesBubbleImage(with: .jsq_messageBubbleGreen())
    }

    // MARK: - Public
    override func didPressSend(_ button: UIButton, withMessageText text: String, senderId: String, senderDisplayName: String, date: Date) {
        let message = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)!
        messages.append(message)
        finishSendingMessage(animated: true)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView, messageDataForItemAt indexPath: IndexPath) -> JSQMessageData {
        return messages[indexPath.item]
    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView, messageBubbleImageDataForItemAt indexPath: IndexPath) -> JSQMessageBubbleImageDataSource {
        let message = messages[indexPath.item]
        return message.senderId == senderId ? outgoingBubble : incomingBubble
    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView, avatarImageDataForItemAt indexPath: IndexPath) -> JSQMessageAvatarImageDataSource? {
        let message = messages[indexPath.item]
        return message.senderId == senderId ? outgoingAvatar : incomingAvatar
    }
}
