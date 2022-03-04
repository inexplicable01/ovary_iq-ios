//
//  LogPeriodsOptionsBottomSheetController.swift
//  OvaryIQ
//
//  Created by Mobcoder on 01/03/22.
//

import UIKit

class LogPeriodsOptionsBottomSheetController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var lblPeriodType: UILabel!
    @IBOutlet private weak var collectionViewSubcategory: UICollectionView!
    // MARK: - Properties
    internal var medicalOptionsDataModel: MedicalOptionsListDataModel?
    internal var logPeriodType: String?
    // MARK: - View Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initalSetup()
        // Do any additional setup after loading the view.
    }
    // MARK: - Notifications Functions
    // MARK: - Private Functions

    private func initalSetup() {
        self.lblPeriodType.text = self.medicalOptionsDataModel?.name
    }
    // MARK: - Button Actions
    @IBAction private func tapBtnCross(_ sender: UIButton) {
        fLog()
        self.dismiss(animated: true, completion: nil)

    }

    @IBAction private func tapBtnTick(_ sender: UIButton) {
        fLog()
        self.dismiss(animated: true, completion: nil)
    }
}
// MARK: -  UICollectionViewDelegate, UICollectionViewDataSource
extension LogPeriodsOptionsBottomSheetController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     //   self.medicalOptionsDataModel?.subCategoryList[indexPath.row].isSelected = !(self.medicalOptionsDataModel?.subCategoryList[indexPath.row].isSelected ?? false)
        self.collectionViewSubcategory.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

    }

    // MARK: - UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.medicalOptionsDataModel?.subCategoryList.count ?? 0

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell: LogPeriodSubCategotyCVC = collectionView.dequeueReusableCell(withReuseIdentifier: LogPeriodSubCategotyCVC.className, for: indexPath) as? LogPeriodSubCategotyCVC {
            cell.configCell(model: self.medicalOptionsDataModel?.subCategoryList[indexPath.row], logPeriodType: self.medicalOptionsDataModel?.name)
                return cell
        }
        return UICollectionViewCell()
    }

    // MARK: - UICollectionViewDelgateFlowLayout
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//             return CGSize(width: collectionView.frame.size.width / 3, height: 30)
//         }
}
