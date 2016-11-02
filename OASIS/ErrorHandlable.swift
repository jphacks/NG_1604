//
//  ErrorHandlable.swift
//  OASIS
//
//  Created by 後藤誉昌 on 2016/11/02.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import UIKit

protocol ErrorHandlable: class {
    func handle(error: Error)
}

extension ErrorHandlable where Self: UIViewController {

    func handle(error: Error) {
        switch error {
        case AppError.connection:
            showAlert(title: "Error.Connection.Title".localized, message: "Error.Connection.Message".localized)
        case AppError.response:
            showAlert(title: "Error.Response.Title".localized, message: "Error.Response.Message".localized)
        case AppError.unauthorized:
            showAlert(title: "Error.Unauthorized.Title".localized, message: "Error.Unauthorized.Message".localized)
        case AppError.cancelled:
            break
        default:
            showAlert(title: "Error.Unknown.Title".localized, message: "Error.Unknown.Message".localized)
        }
    }

    private func showAlert(title: String, message: String?, completion: ((Void) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok".localized, style: .cancel) { _ in
            completion?()
        }
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}
