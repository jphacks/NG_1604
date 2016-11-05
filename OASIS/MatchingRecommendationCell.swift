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
            imageView.kf.setImage(with: user?.image)
            nameLabel.text = user?.name
            universityLabel.text = user?.university
            profileLabel.text = user?.profile
        }
    }
}
