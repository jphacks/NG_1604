//
//  ChatRoomViewController.swift
//  OASIS
//
//  Created by 後藤誉昌 on 2016/11/02.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import UIKit
import Firebase
import JSQMessagesViewController

class ChatRoomViewController: JSQMessagesViewController, Storyboardable {

    // MARK: - Property
    static let storyboardName = "ChatRoom"

    private var incomingBubble: JSQMessagesBubbleImage!
    private var outgoingBubble: JSQMessagesBubbleImage!
    private var incomingAvatar: JSQMessagesAvatarImage!
    private var outgoingAvatar: JSQMessagesAvatarImage!

    var room: Room!
    private var messages: [JSQMessage] = []

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChat()
        setupFirebase()
        title = room.title
    }

    // MARK: - Public
    override func didPressSend(_ button: UIButton, withMessageText text: String, senderId: String, senderDisplayName: String, date: Date) {
        let message = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)!
        messages.append(message)
        finishSendingMessage(animated: true)
        sendTextToDb(text: text)
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

    // MARK: - Private
    private func setupChat() {
        guard let name = FIRAuth.auth()?.currentUser?.displayName else {
            return
        }

        inputToolbar!.contentView!.leftBarButtonItem = nil
        automaticallyScrollsToMostRecentMessage = true

        senderId = name
        senderDisplayName = name

        let bubbleFactory = JSQMessagesBubbleImageFactory()
        incomingBubble = bubbleFactory?.incomingMessagesBubbleImage(with: .jsq_messageBubbleLightGray())
        outgoingBubble = bubbleFactory?.outgoingMessagesBubbleImage(with: .jsq_messageBubbleGreen())
    }

    private func setupFirebase() {
        let rootRef = FIRDatabase.database().reference().child("messages").child(room.id)

        rootRef.queryLimited(toLast: 100).observe(FIRDataEventType.childAdded, with: { snapshot in
            guard let dic = snapshot.value as? [String : AnyObject],
                let name = dic["name"] as? String,
                let text = dic["text"] as? String else {
                    return
            }

            let message = JSQMessage(senderId: name, displayName: name, text: text)!
            self.messages.append(message)
            self.finishReceivingMessage()
        })
    }

    private func sendTextToDb(text: String) {
        guard let name = FIRAuth.auth()?.currentUser?.displayName else {
            return
        }

        let rootRef = FIRDatabase.database().reference().child("messages").child(room.id)

        let post = [
            "name": name,
            "text": text
        ]

        let postRef = rootRef.childByAutoId()
        postRef.setValue(post)
    }
}
