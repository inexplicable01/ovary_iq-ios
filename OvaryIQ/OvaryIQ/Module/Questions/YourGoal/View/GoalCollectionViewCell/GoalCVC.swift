//
//  GoalCVC.swift
//  OvaryIQ
//
//  Created by Mobcoder on 02/02/22.
//

import UIKit

class GoalCVC: BaseCollectionViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet private weak var view: UIView!
    // MARK: - Properties
    // MARK: - View Life Cycle Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    // MARK: - Internal Functions
//    internal func configCell(model: Goal) {
//        lblTitle.text = model.title ?? ""
//        self.view.borderColor = model.isSelected ?? false ? UIColor(red: 255.0 / 255.0, green: 109.0 / 255.0, blue: 147.0 / 255.0, alpha: 1.0) : UIColor(red: 255.0 / 255.0, green: 236.0 / 255.0, blue: 241.0 / 255.0, alpha: 1.0)
//        self.imgViewGoal.image = model.isSelected ?? false ?  model.selectedImage : model.titleImage
//    }

}
