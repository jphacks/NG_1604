//
//  ChatEntranceViewController.swift
//  OASIS
//
//  Created by 後藤誉昌 on 2016/11/02.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import UIKit

class ChatEntranceViewController: UIViewController, Storyboardable {

    // MARK: - Outlet
    @IBOutlet private var tableView: UITableView!

    // MARK: - Property
    static let storyboardName = "ChatEntrance"

    // MARK: - Lifecycle

    // MARK: - Action

    // MARK: - Public

    // MARK: - Private
}

// MARK: - UITableViewDataSource
extension ChatEntranceViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomCell", for: indexPath as IndexPath)

        if let roomCell = cell as? ChatEntranceRoomCell {
//            roomCell.room = Mock.rooms[indexPath.row]
        }

        return cell
    }
}

// MARK: - UITableViewDelegate
extension ChatEntranceViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let next = ChatRoomViewController.makeFromStoryboard()
        next.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(next, animated: true)
    }
}
