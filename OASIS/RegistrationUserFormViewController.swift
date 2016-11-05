//
//  RegistrationUserFormViewController.swift
//  OASIS
//
//  Created by 後藤誉昌 on 2016/11/05.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import Eureka

class RegistrationUserFormViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.backgroundColor = .white

        form = Section("プロフィール")

            <<< TextRow() { row in
                row.title = "名前"
                row.placeholder = "名前を入力してください"
            }

            <<< TextAreaRow() { row in
                row.title = "自己紹介"
                row.placeholder = "自己紹介を入力してください"
            }

        +++ Section("学校")

            <<< TextRow() { row in
                row.title = "学校名"
                row.placeholder = "学校名を入力してください"
            }

            <<< TextRow() { row in
                row.title = "所属"
                row.placeholder = "学部・学科・専攻を入力してください"
            }

            <<< SegmentedRow<String>("学年") { row in
                row.options = ["学部1年", "学部2年", "学部3年", "学部4年", "院1年", "院2年"]
            }
    }
}
