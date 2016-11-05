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

    var name: String {
        return (form.rowBy(tag: "name") as? TextRow)?.value ?? ""
    }

    var profile: String {
        return (form.rowBy(tag: "profile") as? TextRow)?.value ?? ""
    }

    var univ: String {
        return (form.rowBy(tag: "univ") as? TextRow)?.value ?? ""
    }

    var department: String {
        return (form.rowBy(tag: "department") as? TextRow)?.value ?? ""
    }

    var grade: Grade {
        guard let raw = (form.rowBy(tag: "grade") as? TextRow)?.value,
            let grade = Grade(rawValue: raw) else {
            return .undergraduate1
        }
        return grade
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.backgroundColor = .white
        tableView?.separatorInset = .zero

        form
            +++ Section("")

            <<< TextRow("name") { row in
                row.title = "名前"
                row.placeholder = "名前を入力してください"
                row.value = fbProfile?.name
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChangeAfterBlurred
            }
            .cellSetup { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
            .cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }

            <<< TextAreaRow("profile") { row in
                row.title = "自己紹介"
                row.placeholder = "自己紹介を入力してください"
                row.add(rule: RuleRequired())
            }
            .cellSetup { cell, row in
                if !row.isValid {
                    cell.textLabel?.textColor = .red
                }
            }
            .cellUpdate { cell, row in
                if !row.isValid {
                    cell.textLabel?.textColor = .red
                }
            }

            <<< TextRow("univ") { row in
                row.title = "学校名"
                row.placeholder = "学校名を入力してください"
                row.value = fbProfile?.education.last?.name
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChangeAfterBlurred
            }
            .cellSetup { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
            .cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }

            <<< TextRow("department") { row in
                row.title = "学部・学科・専攻"
                row.placeholder = "学部・学科・専攻を入力してください"
                row.value = fbProfile?.education.last?.concentration?.first?.name
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChangeAfterBlurred
            }
            .cellSetup { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
            .cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }

            <<< SegmentedRow<String>("学年") { row in
                row.options = Grade.cases.map { $0.rawValue }
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChangeAfterBlurred
            }
            .cellSetup { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
            .cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
    }
}
