//
//  ActivityIndicatorManager.swift
//  Ding
//
//  Created by Mobcoder Technologies Private Limited on 13/11/21.
//  Copyright © 2021 Naveen. All rights reserved.
//

import Foundation
import UIKit


//class ActivityIndicatorManager {
//
//    var container: UIView = UIView()
//    var loadingView: UIView = UIView()
//    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
//    var isVisible = false
//
////
////    // MARK: - Set Up Application UI Appearance
////
////    func getTopMostViewController() -> UIViewController {
////
////        if var topController = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController {
////            while let presentedViewController = topController.presentedViewController {
////                topController = presentedViewController
////            }
////            return topController
////        }
////        return UIViewController()
////    }
//
//    class var sharedInstance: ActivityIndicatorManager {
//        struct Static {
//            static let instance  = ActivityIndicatorManager()
//        }
//        return Static.instance
//    }
//
//    func showActivityIndicator() {
//        if !self.isVisible {
//
//            self.isVisible = true
//
//           //self.container.bounds = (UIWindow.keyWindow.bounds)!
//            self.container.bounds = (UIApplication.shared.windows.first { $0.isKeyWindow }?.bounds)!
//            self.container.center = (UIApplication.shared.windows.first { $0.isKeyWindow }?.center)!
//            self.container.backgroundColor = UIColor.clear
//
//            self.loadingView.frame = CGRect(x:0, y:0, width: 75, height: 75)
//            self.loadingView.center =  (UIApplication.shared.windows.first { $0.isKeyWindow }?.center)!
//            self.loadingView.backgroundColor = UIColor.clear
//            self.loadingView.clipsToBounds = true
//            self.loadingView.layer.cornerRadius = 10
//
//            self.activityIndicator.frame = CGRect(x:0, y:0, width: 75, height: 75)
//            self.activityIndicator.style = .large
//            self.activityIndicator.center = CGPoint(x: self.loadingView.frame.size.width / 2, y: self.loadingView.frame.size.height / 2)
//
//            self.loadingView.addSubview(self.activityIndicator)
//
//            self.container.addSubview(self.loadingView)
//
//            self.activityIndicator.color = UIColor.black
//
//            (UIApplication.shared.windows.first { $0.isKeyWindow }?.addSubview(self.container))
//          //  UIWindow.keyWindow.addSubview(self.container)
//
//            self.activityIndicator.startAnimating()
//        }
//    }
//
//    func hideActivityIndicator() {
//        self.isVisible = false
//        self.activityIndicator.stopAnimating()
//        self.container.removeFromSuperview()
//    }
//}


