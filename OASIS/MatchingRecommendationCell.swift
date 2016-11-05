//
//  MatchingRecommendationCell.swift
//  OASIS
//
//  Created by Yuto Yazaki on 2016/11/06.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import UIKit
import Spring
import Kingfisher

class MatchingRecommendationCell: UICollectionViewCell {

    // MARK: - Outlet
    @IBOutlet weak var imageView: DesignableImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var universityLabel: UILabel!
    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var scheduleView: ScheduleView!

    // MARK: - Property
    var user: User? {
        didSet {
            guard let user = user else { return }
            imageView.kf.setImage(with: user.image)
            nameLabel.text = user.name
            universityLabel.text = "\(user.university) \(user.department) \(Grade(with: user.grade).rawValue)"
            profileLabel.text = user.profile
            scheduleView.schedule = ClassesScheduler(with: user.classes)
        }
    }

    // MARK: - Action
    @IBAction func didTapDislikeButton(_ sender: AnyObject) {
        guard let user = user else { return }
        WebAPI.Users.dislike(opponent: user.uuid)
            .failure { error, _ in
                print(error)
            }
    }

    @IBAction func didTapLikeButton(_ sender: AnyObject) {
        guard let user = user else { return }
        WebAPI.Users.like(opponent: user.uuid)
            .failure { error, _ in
                print(error)
        }
    }
}
