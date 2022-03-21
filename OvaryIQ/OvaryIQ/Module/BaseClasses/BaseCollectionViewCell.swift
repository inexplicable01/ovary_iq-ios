//
//  BaseCollectionViewCell.swift
//  Ding
//
//  Created by Mobcoder Technologies Private Limited on 14/11/21.
//  Copyright © 2021 Naveen. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets

    // MARK: - Properties

    // MARK: - View Life Cycle Functions

    override func awakeFromNib() {
        super.awakeFromNib()

        // dLog(message: "CollectionCellStart :: \(String(describing: type(of: self)))")

        self.initialSetup()
    }

    // MARK: - Private Functions

    private func initialSetup() {
    }

    // MARK: - Internal Functions

    // MARK: - Button Actions
}

