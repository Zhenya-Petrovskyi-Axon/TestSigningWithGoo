//
//  GoggleSignInService.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 20.05.2021.
//

import UIKit
import GoogleSignIn

class GoogleSignInService: NSObject, GIDSignInDelegate {
    
    private static let clientID = "841354916093-e2oknqnmbqsr76e6bpftc4o6sf7tlbkv.apps.googleusercontent.com"
    var completion: ((_ user: GIDGoogleUser?, _ error: Error?) -> Void)?
    private var gid: GIDSignIn = GIDSignIn.sharedInstance()
    
    func setup() {
        print("GoogleSignInService - setup")
        gid.clientID = GoogleSignInService.clientID
        gid.delegate = self
    }
    
    func logout(completion: @escaping () -> Void) {
        gid.signOut()
        print("GoogleSignInService - logged out")
        completion()
    }
    
    func sign(_ signIn: GIDSignIn?, didSignInFor user: GIDGoogleUser?, withError error: Error?) {
        guard let completion = completion else {
            assertionFailure("GoogleSignInService - delegate but no completion")
            return
        }
        completion(user, error)
        self.completion = nil
    }
    

}
