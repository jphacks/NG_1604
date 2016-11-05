//
//  ScheduleCell.swift
//  OASIS
//
//  Created by Yuto Yazaki on 2016/11/05.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import UIKit

class ScheduleCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    var isFree: Bool = false {
        didSet {
            if isFree {
                self.backgroundColor = .green
            } else {
                image.isHidden = true
            }
        }
    }
}
