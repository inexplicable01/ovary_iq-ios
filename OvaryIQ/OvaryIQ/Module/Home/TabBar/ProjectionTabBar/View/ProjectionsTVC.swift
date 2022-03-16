//
//  ProjectionsTVC.swift
//  OvaryIQ
//
//  Created by Mobcoder on 03/03/22.
//

import UIKit

class ProjectionsTVC: BaseTableViewCell {
    // MARK: - IBOutlets
    @IBOutlet private weak var lblProjectionName: UILabel!
    @IBOutlet private weak var lblProjectionDate: UILabel!
    @IBOutlet private weak var lblPregancyTest: UILabel!
    @IBOutlet private weak var lblGestationDate: UILabel!
    @IBOutlet private weak var viewGestation: UIView!
    @IBOutlet private  weak var lblExpectedDeliveryDate: UILabel!
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
    internal func configCell(model: ProjectionDataModel?) {
        self.lblProjectionName.text = model?.data?.procedureName ?? ""
        self.lblProjectionDate.text = "\(Helper.convertDateFormat(InputDateFormat: DateFormat.yearMonthDate.rawValue, OutputDateFormate: DateFormat.monthDateYear.rawValue, date: model?.data?.procedureDate ?? ""))"
        self.lblPregancyTest.text =  Helper.convertDateFormat(InputDateFormat: DateFormat.yearMonthDate.rawValue, OutputDateFormate: DateFormat.monthDateYear.rawValue, date: model?.data?.pregnancyTestDate ?? "")
        self.lblGestationDate.text = model?.data?.gestationDays ?? ""
        self.viewGestation.isHidden = model?.data?.gestationDays == "0" ? true : false
        self.lblExpectedDeliveryDate.text = Helper.convertDateFormat(InputDateFormat: DateFormat.yearMonthDate.rawValue, OutputDateFormate: DateFormat.monthDateYear.rawValue, date: model?.data?.expectedDeliveryDate ?? "")
    }

}
