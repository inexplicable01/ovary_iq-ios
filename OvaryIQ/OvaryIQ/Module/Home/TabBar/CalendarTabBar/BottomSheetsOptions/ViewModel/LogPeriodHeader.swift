//
//  LogPeriodHeader.swift
//  OvaryIQ
//
//  Created by Mobcoder on 16/03/22.
//

import UIKit
protocol LogPeriodHeaderDelegate {
    func headerBtnPressed(isSelected: Bool)
}

class LogPeriodHeader: UICollectionReusableView {
    // MARK: - IBOutlet
    @IBOutlet private weak var selectedView: UIView!
    @IBOutlet private weak var lblSubCategoryPeriodType: UILabel!
    @IBOutlet private weak var imgViewPeriodType: UIImageView!
    @IBOutlet private weak var imgTick: UIImageView!
    @IBOutlet private weak var headerBtn: UIButton!
    // MARK: - Properties
    internal var delegate: LogPeriodHeaderDelegate?
    // MARK: - View Life Cycle Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configCell(isSelected: false)
        // Initialization code
    }
    // MARK: - Internal Functions
    internal func configCell(isSelected: Bool) {
        selectedView.borderWidth = isSelected == true ? 1 : 0
        imgTick.isHidden = !(isSelected ?? false)
    }
    // MARK: - Button Actions
    @IBAction private func tapBtnAll(_ sender: UIButton) {
        fLog()
        sender.isSelected = !sender.isSelected
        self.configCell(isSelected: sender.isSelected)
        self.delegate?.headerBtnPressed(isSelected: sender.isSelected)
    }

}
