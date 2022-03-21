//
//  TabBarController.swift
//  OvaryIQ
//
//  Created by Mobcoder on 24/02/22.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "SourceSansPro-Bold", size: 10)!], for: .normal)
        tabBar.layer.shadowOffset = CGSize(width: 1, height: 0)
        tabBar.layer.shadowRadius = 5
        tabBar.layer.cornerRadius = 25
        tabBar.layer.shadowColor = UIColor.gray.cgColor
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.layer.shadowOpacity = 0.2
        // Do any additional setup after loading the view.
    }
}
