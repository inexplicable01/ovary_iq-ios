//
//  CalendarCollectionViewCell.swift
//  OvaryIQ
//
//  Created by Mobcoder on 19/01/22.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var lblDate: UILabel!

    // MARK: - Properties
    // MARK: - View Life Cycle Functions

    override class func awakeFromNib() {
    }

    // MARK: - Internal Functions
    internal func configCell(date: String) {
        lblDate.text = date
    }

}
