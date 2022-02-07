//
//  Helper.swift
//  OvaryIQ
//
//  Created by Mobcoder on 19/01/22.
//

import Foundation
import UIKit
import Lottie
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
    //MARK: -  Show AnswerFewQuestions Screen as root controller
    class func showAnswerFewQuestionsScreen() {
        let vc = Storyboard.Questions.instantiateViewController(withIdentifier: AnswersFewQuestionsVC.className) as! AnswersFewQuestionsVC
        let nav = UINavigationController.init(rootViewController: vc)
        nav.isNavigationBarHidden = true
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = nav
            window.makeKeyAndVisible()
        }
    }

    //Show egg loader
    class func showLoader() {
        let controller = getTopMostViewController()
        hideLoader()
        var progressView: AnimationView?
        progressView = AnimationView(name: "Loader")
        progressView?.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        progressView?.center = controller.view.center
        progressView?.contentMode = .scaleAspectFill
        progressView?.animationSpeed = 1
        progressView?.loopMode = .loop
        controller.view.addSubview(progressView!)
        progressView?.play()
    }
   class func hideLoader() {
       let controller = getTopMostViewController()
       for controller in controller.view.subviews where controller is AnimationView {
           controller.removeFromSuperview()
        }
    }

    // MARK: - Set Up Application UI Appearance

   class func getTopMostViewController() -> UIViewController {

        if var topController = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return UIViewController()
    }

}
