//
//  MatchingRecommendationCell.swift
//  OASIS
//
//  Created by Yuto Yazaki on 2016/11/06.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import UIKit
import Spring

class MatchingRecommendationCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: DesignableImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var universityLabel: UILabel!
    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var scheduleView: ScheduleView!
}
