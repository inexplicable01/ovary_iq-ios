//
//  PopOverTVC.swift
//  OvaryIQ
//
//  Created by Mobcoder on 15/03/22.
//

import UIKit

class PopOverTVC: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet private weak var imageViewMedicationalSubCategory: UIImageView!
    @IBOutlet weak var lblMedicationalSubcategory: UILabel!
    // MARK: - Properties
    // MARK: - view life cycle function
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // MARK: - Internal Functions
    internal func configCell(model: SubCategoryList?) {
        self.lblMedicationalSubcategory.text = model?.name ?? ""
        self.imageViewMedicationalSubCategory.image = UIImage(named: model?.subCategoryImage ?? "")
    }

}
