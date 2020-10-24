//
//  Auth.swift
//  FitMove
//
//  Created by Peter Andrew on 14/10/20.
//

import Foundation
import UIKit
import GoogleSignIn

class Auth: NSObject {
    typealias AuthCompletion = (_ err:Error?,_ data:String)->()
    static var instance = Auth()
    static var loginCompletion:AuthCompletion? = nil
    
    static func login(authVC:UIViewController, completion:@escaping AuthCompletion) {
        GIDSignIn.sharedInstance()?.delegate = Auth.instance
        GIDSignIn.sharedInstance()?.presentingViewController = authVC
        GIDSignIn.sharedInstance()?.signIn()
        Auth.loginCompletion = completion
    }
    
    static func loggout(completion:AuthCompletion) {
        completion(nil, "LOGGEDOUT")
    }
}

extension Auth: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error == nil {
            let json = [
                "email": user.profile.email!,
                "name": user.profile.name!
            ]
            HTTPRequest.post(urlString: APIEndpoint.signup, json: json) {data, response, error in
                if error != nil {
                    print(error!)
                } else {
                    let userId = try! JSONDecoder().decode(userID.self, from: data!)
                    LocalDB.setTokenID(id: userId.id)
                }
            }
        }
        if let completion = Auth.loginCompletion {
            completion(error, user.profile.name!)
            Auth.loginCompletion = nil
        }
            
    }
}


struct userID:Decodable {
    let id:String
}
