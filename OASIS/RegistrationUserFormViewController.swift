//
//  RegistrationUserFormViewController.swift
//  OASIS
//
//  Created by 後藤誉昌 on 2016/11/05.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import Eureka

class RegistrationUserFormViewController: FormViewController {

    // MARK: - Property
    var fbProfile: FBProfile?

    var name: String? {
        return (form.rowBy(tag: "name") as? TextRow)?.value
    }

    var profile: String? {
        return (form.rowBy(tag: "profile") as? TextRow)?.value
    }

    var univ: String? {
        return (form.rowBy(tag: "univ") as? TextRow)?.value
    }

    var department: String? {
        return (form.rowBy(tag: "department") as? TextRow)?.value
    }

    var grade: String? {
        return (form.rowBy(tag: "grade") as? TextRow)?.value
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.backgroundColor = .white

        form = Section("")

            <<< TextRow("name") { row in
                row.title = "名前"
                row.placeholder = "名前を入力してください"
                row.value = fbProfile?.name
            }

            <<< TextAreaRow("profile") { row in
                row.title = "自己紹介"
                row.placeholder = "自己紹介を入力してください"
            }

        +++ Section("")

            <<< TextRow("univ") { row in
                row.title = "学校名"
                row.placeholder = "学校名を入力してください"
                row.value = fbProfile?.education.last?.name
            }

            <<< TextRow("department") { row in
                row.title = "学部・学科・専攻"
                row.placeholder = "学部・学科・専攻を入力してください"
                row.value = fbProfile?.education.last?.concentration?.first?.name
            }

            <<< SegmentedRow<String>("学年") { row in
                row.options = ["学部1年", "学部2年", "学部3年", "学部4年", "院1年", "院2年"]
            }
    }
}
