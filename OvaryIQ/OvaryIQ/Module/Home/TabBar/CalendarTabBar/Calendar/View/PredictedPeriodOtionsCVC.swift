//
//  PredictedPeriodCVC.swift
//  OvaryIQ
//
//  Created by Mobcoder on 24/02/22.
//

import UIKit

class PredictedPeriodOtionsCVC: BaseCollectionViewCell {
    // MARK: - IBOutlet
    @IBOutlet private weak var imgViewPredictedPeriod: UIImageView!
    @IBOutlet private weak var lblPredictedPeriodType: UILabel!
    // MARK: - Properties
    // MARK: - View Life Cycle Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    // MARK: - Internal Functions
    internal func configCell(model: PredictedPeriod?) {
        self.lblPredictedPeriodType.text = model?.periodName
        self.imgViewPredictedPeriod.image = UIImage(named: model?.periodImageName ?? "")

    }
}
