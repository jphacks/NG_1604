//
//  SceneRouter.swift
//  OASIS
//
//  Created by 後藤誉昌 on 2016/11/02.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import UIKit

class SceneRouter {

    enum Scene {
        case registration, main

        var viewController: UIViewController {
            switch self {
            case .registration:
                return RegistrationController.makeFromStoryboard()
            case .main:
                return MainController.makeFromStoryboard()
            }
        }
    }

    // MARK: - Property
    static let shared = SceneRouter()
    weak var window: UIWindow!

    // MARK: - Lifecycle
    private init() {}

    // MARK: - Public
    func route(scene: Scene, animated: Bool = true) {
        let viewController = scene.viewController

        if animated {
            viewController.view.isHidden = true
            window.rootViewController = viewController

            UIView.transition(with: window, duration: 0.2, options: .transitionCrossDissolve, animations: {
                viewController.view.isHidden = false
            },
            completion: nil)
        } else {
            window.rootViewController = viewController
        }
    }
}
