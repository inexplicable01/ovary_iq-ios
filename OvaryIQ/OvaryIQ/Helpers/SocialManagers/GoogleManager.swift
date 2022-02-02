//
//  GoogleManager.swift
//  OvaryIQ
//
//  Created by Mobcoder on 01/02/22.
//

import Foundation
import GoogleSignIn
import UIKit

/*
 Step 1: Open https://developers.google.com/identity/sign-in/ios/start?ver=swift
 Step 2: Install pod 'GoogleSignIn'
 Step 3: Created an OAuth client ID
 Step 4: Add a URL scheme to your project.
 */

class GoogleManager: NSObject {
    // 121267152265-f2iln3jdd2m4c2ji9k7r49llhl3k9rlb.apps.googleusercontent.com
    // com.googleusercontent.apps.121267152265-f2iln3jdd2m4c2ji9k7r49llhl3k9rlb

    private var googleLoginResult: ((_ socialUserInfo: SocialUserInfo?, _ message: String?, _ success: Bool) -> Void)?

    // MARK: - Properties ::
    internal static let shared: GoogleManager = {
        GoogleManager()
    }()

    // MARK: - Functions ::

    func initilize() {
        print("GoogleManager :: Initilize")
        //GIDSignIn.sharedInstance.clientID = "121267152265-f2iln3jdd2m4c2ji9k7r49llhl3k9rlb.apps.googleusercontent.com"
       // GIDSignIn.sharedInstance.delegate = self
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return GoogleSignIn.GIDSignIn.sharedInstance.handle(url)
    }

    func login(viewController: UIViewController, completionClosure: @escaping (_ socialUserInfo: SocialUserInfo?, _ message: String?, _ success: Bool) -> Void) {
        print("GoogleManager :: Google Login Initiated")
        //SharedPref.shared.isUserLoggedIn = true

        let signInConfig = GIDConfiguration.init(clientID: "121267152265-f2iln3jdd2m4c2ji9k7r49llhl3k9rlb.apps.googleusercontent.com")
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: viewController) { user, error in

            if let error = error {
                self.googleLoginResult?(nil, error.localizedDescription, false)
            } else {
                guard let user = user else { return }
                let name = user.profile?.name ?? ""
                let email = user.profile?.email ?? ""
                let userId = user.userID ?? ""
                var imageURL: String = ""
                if let profilePic = user.profile?.imageURL(withDimension: 200) {
                    imageURL = profilePic.absoluteString
                }
                let socialUserInfo = SocialUserInfo(type: SocialLoginType.google, socialId: userId, name: name, email: email, profilePic: imageURL)

                print("GoogleManager :: User Info = UserId: \(userId), UserName: \(name), UserEmail: \(email), UserProfilePic: \(imageURL)")

                self.googleLoginResult?(socialUserInfo, "Google login success", true)
            }
            self.googleLoginResult = { socialUserInfo, message, success in
                completionClosure(socialUserInfo, message, success)
              }

        }
    }

    func logout() {
        GoogleSignIn.GIDSignIn.sharedInstance.signOut()
    }

    func isUserLogin() -> Bool {
        if GoogleSignIn.GIDSignIn.sharedInstance.currentUser != nil {
            return true
        } else {
            return false
        }
    }

    // MARK: - GIDSignInDelegate -

//    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
//        if let error = error {
//            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue ||
//                (error as NSError).code == GIDSignInErrorCode.unknown.rawValue {
//                print("GoogleManager :: Google Login Error 1 :: \(error.localizedDescription)")
//                self.googleLoginResult?(nil, "Google login error", false)
//            } else if (error as NSError).code == GIDSignInErrorCode.canceled.rawValue {
//                print("GoogleManager :: Google Login Error 1 :: \(error.localizedDescription)")
//                self.googleLoginResult?(nil, "Google login cancelled", false)
//            } else {
//                print("GoogleManager :: Google Login Error 2 :: \(error.localizedDescription)")
//                self.googleLoginResult?(nil, "Google login error", false)
//            }
//        } else {
//            guard let user = user else { return }
//            let name = user.profile?.name ?? ""
//            let email = user.profile?.email ?? ""
//            let userId = user.userID ?? ""
//            var imageURL: String = ""
//            if let profilePic = user.profile?.imageURL(withDimension: 200) {
//                imageURL = profilePic.absoluteString
//            }
//
//            let socialUserInfo = SocialUserInfo(type: SocialLoginType.facebook, userId: userId, name: name, email: email, profilePic: imageURL)
//
//            print("GoogleManager :: User Info = UserId: \(userId), UserName: \(name), UserEmail: \(email), UserProfilePic: \(imageURL)")
//
//            self.googleLoginResult?(socialUserInfo, "Google login success", true)
//        }
//    }
}
