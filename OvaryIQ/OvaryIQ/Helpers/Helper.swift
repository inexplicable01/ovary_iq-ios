//
//  Helper.swift
//  OvaryIQ
//
//  Created by Mobcoder on 19/01/22.
//

import Foundation
import UIKit
class Helper {

    //MARK: -  Show Home Screen as root controller
    class func showHomeScreen() {
        let vc = Storyboard.Home.instantiateViewController(withIdentifier: HomeVC.className) as! HomeVC
        let nav = UINavigationController.init(rootViewController: vc)
        nav.isNavigationBarHidden = true
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = nav
            window.makeKeyAndVisible()
        }
    }

    //MARK: -  Show Login Screen as root controller
    class func showLoginScreen() {
        let vc = Storyboard.Auth.instantiateViewController(withIdentifier: AuthLoginVC.className) as! AuthLoginVC
        let nav = UINavigationController.init(rootViewController: vc)
        nav.isNavigationBarHidden = true
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = nav
            window.makeKeyAndVisible()
        }
    }
}
