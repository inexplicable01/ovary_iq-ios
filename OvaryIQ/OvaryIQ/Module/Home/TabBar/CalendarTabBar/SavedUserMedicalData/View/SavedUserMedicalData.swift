//
//  SavedUserMedicalData.swift
//  OvaryIQ
//
//  Created by Mobcoder on 09/03/22.
//

import Foundation
import UIKit
class SavedUserMedicalData: UIView {
    // MARK: - IBOutlets
    @IBOutlet private weak var lblDate: UILabel!
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var collectionViewMedicationIcon: UICollectionView!
    // MARK: - Properties
    // MARK: - View Life Cycle Functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
        queuedFatalError("init(coder:) has not been implemented")
    }
    // MARK: - Private and Internal Functions
       private func commonInit() {
            let bundle = Bundle(for: type(of: self))
           bundle.loadNibNamed(SavedUserMedicalData.className, owner: self, options: nil)
            addSubview(contentView)
            contentView.frame = bounds
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            initCollectionView()
        }

        private func initCollectionView() {
            let nib = UINib(nibName: SavedMedicationsDataIconCVC.className, bundle: nil)
            collectionViewMedicationIcon.register(nib, forCellWithReuseIdentifier: SavedMedicationsDataIconCVC.className)
//            collectionViewMedicationIcon.backgroundColor = .red
            collectionViewMedicationIcon.dataSource = self
            collectionViewMedicationIcon.delegate = self
        }

}
// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension SavedUserMedicalData: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

    }

    // MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            if let cell: SavedMedicationsDataIconCVC = collectionViewMedicationIcon.dequeueReusableCell(withReuseIdentifier: SavedMedicationsDataIconCVC.className, for: indexPath) as? SavedMedicationsDataIconCVC {
              //  cell.configCell(model: goalArr[indexPath.row], index: indexPath.row)
                return cell
            } else {
                return UICollectionViewCell()
            }

    }

    // MARK: - UICollectionViewDelgateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0)
//    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionViewMedicationIcon.frame.size.width / 2
        return CGSize(width: width - 1, height: width - 1)
    }

}
