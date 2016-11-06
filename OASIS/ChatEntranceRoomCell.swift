//
//  ChatEntranceRoomCell.swift
//  OASIS
//
//  Created by 後藤誉昌 on 2016/11/03.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import UIKit
import Kingfisher

final class ChatEntranceRoomCell: UITableViewCell {

    // MARK: - Outlet
    @IBOutlet private weak var thumbView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!

    // MARK: - Property
    var room: Room? {
        didSet {
            thumbView.kf.setImage(with: URL(string: "http://www.othlo.tech/images/members/hide.png"))
            nameLabel.text = room?.title
            messageLabel.text = room?.lastMessage
        }
    }
}
