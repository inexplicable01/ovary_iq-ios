//
//  GoalTVC.swift
//  OvaryIQ
//
//  Created by Mobcoder on 17/01/22.
//

import UIKit

class GoalTVC: BaseTableViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var view: UIView!
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet weak var imgViewGoal: UIImageView!

    // MARK: - Properties
    // MARK: - View Life Cycle Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    // MARK: - Internal Functions

    internal func configCell(model: Goal) {
        lblTitle.text = model.title ?? ""
        self.view.borderColor = model.isSelected ?? false ? UIColor(red: 255.0 / 255.0, green: 109.0 / 255.0, blue: 147.0 / 255.0, alpha: 1.0) : UIColor(red: 255.0 / 255.0, green: 236.0 / 255.0, blue: 241.0 / 255.0, alpha: 1.0)
        self.imgViewGoal.image = model.isSelected ?? false ?  model.selectedImage : model.titleImage
    }

}
