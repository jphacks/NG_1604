//
//  RegistrationUserViewController.swift
//  OASIS
//
//  Created by 後藤誉昌 on 2016/11/02.
//  Copyright © 2016年 othlotech. All rights reserved.
//

import UIKit
import Firebase
import FacebookCore

class RegistrationUserViewController: UIViewController, Storyboardable, ErrorHandlable {

    // MARK: - Property
    static let storyboardName = "RegistrationUser"
//    struct UserProfileRequest: GraphRequestProtocol {
//        let graphPath = "me"
//        let parameters: [String : Any]? = [:]
//        let accessToken: AccessToken?
//        let httpMethod: GraphRequestHTTPMethod = .GET
//        let apiVersion: GraphAPIVersion = .defaultVersion
//
//        init(token: String) {
//            self.accessToken = AccessToken(authenticationToken: token)
//        }
//        
//    }

    // MARK: - Action
    @IBAction private func submitBtnDidTap(_ sender: UIButton) {
        guard let user = FIRAuth.auth()?.currentUser else { return }

        user.getTokenWithCompletion { (token, error) in
            guard let token = token else { return }
            print(token)
            self.fetchUserProfile(token: AccessToken(authenticationToken: token))
        }
//        let request = user.profileChangeRequest()
//        request.displayName = "ヒデちゃん"
//        request.photoURL = URL(string: "http://www.othlo.tech/images/members/hide.png")
//        request.commitChanges { error in
//            if let error = error {
//                self.handle(error: error)
//            } else {
//                let next = RegistrationTimeTableViewController.makeFromStoryboard()
//                self.navigationController?.pushViewController(next, animated: true)
//            }
//        }
    }

    // MARK: - Private
    private func fetchUserProfile(token: AccessToken) {
        let graphRequest = GraphRequest(graphPath: "me", parameters: [:], accessToken: token, httpMethod: .GET, apiVersion: .defaultVersion)
        graphRequest.start { (urlResponse, requestResult) in
            switch requestResult {
            case .failed(let error):
                print("error in graph request:", error)
                break
            case .success(let graphResponse):
                if let responseDictionary = graphResponse.dictionaryValue {
                    dump(responseDictionary)
                }
            }
            
        }
//        let connection = GraphRequestConnection()
//        connection.add(<#T##request: T##T#>, batchEntryName: <#T##String?#>, completion: <#T##(HTTPURLResponse?, GraphRequestResult<T>) -> Void?##(HTTPURLResponse?, GraphRequestResult<T>) -> Void?##(HTTPURLResponse?, GraphRequestResult<T>) -> Void#>)
    }
}
