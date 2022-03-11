//
//  MedicationsOptionsCVC.swift
//  OvaryIQ
//
//  Created by Mobcoder on 28/02/22.
//

import UIKit

class MedicationsOptionsCVC: BaseCollectionViewCell {
    // MARK: - IBOutlet
    @IBOutlet private weak var imgViewPeriod: UIImageView!
    @IBOutlet private weak var lblPeriodType: UILabel!
    // MARK: - Properties
    // MARK: - View Life Cycle Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    // MARK: - Internal Functions
    internal func configCell(model: MedicalOptionsListDataModel?) {
        self.lblPeriodType.text = model?.name
        self.imgViewPeriod.image = UIImage(named: model?.categoryImage ?? "")

    }
}
