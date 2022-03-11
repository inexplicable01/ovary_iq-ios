//
//  LogPeriodSubCategotyCVC.swift
//  OvaryIQ
//
//  Created by Mobcoder on 01/03/22.
//

import UIKit

class LogPeriodSubCategotyCVC: BaseCollectionViewCell {
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
    internal func configCell(model: SubCategoryListDataModel?, logPeriodType: String?) {
        selectedView.borderWidth = model?.isSelected == true ? 1 : 0
        imgTick.isHidden = !(model?.isSelected ?? false)
        switch logPeriodType {
        case LogPeriodCategoryType.logPeriod.rawValue:
            self.lblSubCategoryPeriodType.text = model?.periodFlowName ?? ""
            if let image = model?.periodFlowIcon {
               self.imgViewPeriodType.image = UIImage(named: image)
            }
        case LogPeriodCategoryType.medication.rawValue:
            self.lblSubCategoryPeriodType.text = model?.medicationName ?? ""
            if let image = model?.medicationIcon {
               self.imgViewPeriodType.image = UIImage(named: image)
            }
        case LogPeriodCategoryType.procedure.rawValue:
            self.lblSubCategoryPeriodType.text = model?.procedureName ?? ""
            if let image = model?.procedureIcon {
               self.imgViewPeriodType.image = UIImage(named: image)
            }
        case LogPeriodCategoryType.activity.rawValue:
            self.lblSubCategoryPeriodType.text = model?.activityName ?? ""
            if let image = model?.activityIcon {
               self.imgViewPeriodType.image = UIImage(named: image)
            }
        case LogPeriodCategoryType.symptoms.rawValue:
            self.lblSubCategoryPeriodType.text = model?.symptomName ?? ""
            if let image = model?.symptomIcon {
               self.imgViewPeriodType.image = UIImage(named: image)
            }
        case LogPeriodCategoryType.pregnancyTest.rawValue:
            self.lblSubCategoryPeriodType.text = model?.pregnancyTestName ?? ""
            if let image = model?.pregnancyTestIcon {
               self.imgViewPeriodType.image = UIImage(named: image)
            }
        default:
            self.lblSubCategoryPeriodType.text = model?.periodFlowName ?? ""
            if let image = model?.medicationIcon {
               self.imgViewPeriodType.image = UIImage(named: image)
            }

        }
       // self.lblSubCategoryPeriodType.text = model.
      //  self.lblPeriodType.text = model?.name
        //self.imgViewPeriod.image = UIImage(named: model?.categoryImage ?? "")
    }
}
