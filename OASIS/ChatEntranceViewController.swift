//
//  ChatEntranceViewController.swift
//  OASIS
//
//  Created by 後藤誉昌 on 2016/11/02.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import UIKit
import Firebase

class ChatEntranceViewController: UIViewController, Storyboardable, ErrorHandlable {

    // MARK: - Outlet
    @IBOutlet private var tableView: UITableView!

    // MARK: - Property
    static let storyboardName = "ChatEntrance"
    fileprivate var rooms: [Room] = []

    // MARK: - Lifecycle
    override func viewDidLoad() {
        getRooms()
    }

    // MARK: - Private
    func getRooms() {
        guard let uuid = WebAPI.uuid else { return }
        let ref = FIRDatabase.database().reference().child("users").child(uuid).child("matches")

        ref.queryLimited(toLast: 100).observe(FIRDataEventType.childAdded, with: { snapshot in
            guard let id = snapshot.value(forKey: "room_id") as? String else { return }

            Firebase.showRoom(id: id)
                .success { room in
                    self.rooms.append(room)
                }
                .failure { errorInfo in
                    guard let error = errorInfo.error else { return }
                    self.handle(error: error)
                }
        })
    }
}

// MARK: - UITableViewDataSource
extension ChatEntranceViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomCell", for: indexPath as IndexPath)

        if let roomCell = cell as? ChatEntranceRoomCell {
            roomCell.room = rooms[indexPath.row]
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
