//
//  MyProfileTVC.swift
//  OvaryIQ
//
//  Created by Mobcoder on 25/02/22.
//

import UIKit

class SideOptionsTVC: BaseTableViewCell {
    // MARK: - IBOutlets
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var imgView: UIImageView!
    @IBOutlet private weak var lblBottomGreyLine: UIView!
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
    // MARK: - Private Functions
    // MARK: - Internal Functions

    internal func configCell(sideMenuOption: Profile) {
        self.lblTitle.text = sideMenuOption.title
        self.imgView.image = sideMenuOption.img
        self.lblBottomGreyLine.isHidden = sideMenuOption.isHideGreyLine ?? false
    }

    // MARK: - Button Actions
}
