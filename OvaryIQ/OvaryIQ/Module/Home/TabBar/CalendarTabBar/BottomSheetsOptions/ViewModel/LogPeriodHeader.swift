//
//  LogPeriodHeader.swift
//  OvaryIQ
//
//  Created by Mobcoder on 16/03/22.
//

import UIKit

class LogPeriodHeader: UICollectionReusableView {
    // MARK: - IBOutlet
    @IBOutlet private weak var selectedView: UIView!
    @IBOutlet private weak var lblSubCategoryPeriodType: UILabel!
    @IBOutlet private weak var imgViewPeriodType: UIImageView!
    @IBOutlet private weak var imgTick: UIImageView!
    // MARK: - Properties
    // MARK: - View Life Cycle Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    // MARK: - Internal Functions
    internal func configCell(isSelected: Bool) {
       // selectedView.borderWidth = isSelected == true ? 1 : 0
       // imgTick.isHidden = !(isSelected ?? false)
       // lblSubCategoryPeriodType.text = "ALL"

    }
}
