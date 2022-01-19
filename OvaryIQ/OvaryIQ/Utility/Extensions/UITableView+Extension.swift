//
//  UITableView+Extension.swift
//  OvaryIQ
//
//  Created by Mobcoder on 18/01/22.
//

import Foundation
import UIKit

extension UITableView {
    func emptyCell() -> UITableViewCell {
        let cellDefault:UITableViewCell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cellDefault.selectionStyle = .none
        cellDefault.textLabel?.text = ""
        cellDefault.imageView?.image = nil
        return cellDefault
    }
}

protocol ReusableView: AnyObject {
    static var defaultReuseIdentifier: String { get }
}

protocol NibLoadableView: AnyObject {
    static var nibName: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: Self.self)
    }
}
