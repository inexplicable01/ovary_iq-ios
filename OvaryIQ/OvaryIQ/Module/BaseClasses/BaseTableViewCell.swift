//
//  BaseTableViewCell.swift
//  OvaryIQ
//
//  Created by Mobcoder on 14/01/22.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets

    // MARK: - Properties

    // MARK: - View Life Cycle Functions

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        self.accessoryType = .none
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        self.initialSetup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Private Functions

    private func initialSetup() {
    }

    // MARK: - Internal Functions

    // MARK: - Button Actions
}
