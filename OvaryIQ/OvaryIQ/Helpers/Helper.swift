//
//  Helper.swift
//  OvaryIQ
//
//  Created by Mobcoder on 19/01/22.
//

import Foundation
import UIKit
class Helper {

    //MARK: -  Show Home Screen
    class func showHomeScreen() {
        let vc = Storyboard.Auth.instantiateViewController(withIdentifier: "") as! AuthLoginVC
        let nav = UINavigationController.init(rootViewController: vc)
        nav.isNavigationBarHidden = true
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = nav
            window.makeKeyAndVisible()
        }
    }

}
