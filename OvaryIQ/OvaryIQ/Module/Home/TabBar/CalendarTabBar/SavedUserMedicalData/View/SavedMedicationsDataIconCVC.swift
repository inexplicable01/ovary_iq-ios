//
//  SavedMedicationsDataIconCVC.swift
//  OvaryIQ
//
//  Created by Mobcoder on 10/03/22.
//

import UIKit
class SavedMedicationsDataIconCVC: UICollectionViewCell {
    // MARK: - IBOutlets

    @IBOutlet weak var medicalOptionsImage: UIImageView!
    // MARK: - Properties
    // MARK: - View Life Cycle Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    // MARK: - Internal Functions
    internal func configCell(model: String?, isRenderImage: Bool) {
//        medicalOptionsImage.isHidden = model == UIImageType.regularBledding.rawValue ? true : false

        if isRenderImage {
            self.medicalOptionsImage.image = UIImage(named: model ?? "")?.withRenderingMode(.alwaysTemplate)
        } else {
            self.medicalOptionsImage.image = UIImage(named: model ?? "")?.withRenderingMode(.alwaysOriginal)
        }

    }

}
