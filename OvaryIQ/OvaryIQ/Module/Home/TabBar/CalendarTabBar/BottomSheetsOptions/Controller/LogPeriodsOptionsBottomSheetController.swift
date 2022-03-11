//
//  LogPeriodsOptionsBottomSheetController.swift
//  OvaryIQ
//
//  Created by Mobcoder on 01/03/22.
//

import UIKit
protocol LogPeriodsOptionsBottomSheetControllerDelegate {
    func goBackToCalendarController(saveMedicationsSelectedDataModel: SaveMedicationRequestModel)
}

class LogPeriodsOptionsBottomSheetController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var lblPeriodType: UILabel!
    @IBOutlet private weak var collectionViewSubcategory: UICollectionView!
    // MARK: - Properties
    internal var medicalOptionsDataModel: MedicalOptionsListDataModel?
    internal var logPeriodType: String?
    internal var selectedDate: String = ""
    internal var selectedIds = [Int]()
    internal var saveMedicationRequestModel = SaveMedicationRequestModel()
    internal var medicationModel = [MedicationModel]()
    internal var delegate: LogPeriodsOptionsBottomSheetControllerDelegate?
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
        self.dismiss(animated: true) {
            if self.selectedDate.isEmpty {
                AlertControllerManager.showToast(message: ErrorMessages.selectPeriodStartDate.localizedString, type: .error)
            } else {
                if let categoryModel = self.medicalOptionsDataModel?.subCategoryList {
                    self.selectedIds.removeAll()
                    for ( _ ,mod) in categoryModel.enumerated() {
                        if mod.isSelected {
                            if let medicationId = mod.id {
                                self.selectedIds.append(medicationId)
                            }
                        }
                    }
                    self.medicationModel.append(MedicationModel(id: self.selectedIds, date: self.selectedDate ?? ""))
                    self.saveMedicationRequestModel.medicationId = self.medicationModel
                    self.saveMedicationRequestModel.periodType = self.medicalOptionsDataModel?.name

                }
                self.delegate?.goBackToCalendarController(saveMedicationsSelectedDataModel: self.saveMedicationRequestModel)
            }
        }
    }
}
 // MARK: -  UICollectionViewDelegate, UICollectionViewDataSource
extension LogPeriodsOptionsBottomSheetController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let medicationSubCatModel = self.medicalOptionsDataModel?.subCategoryList {
            if self.medicalOptionsDataModel?.name == LogPeriodCategoryType.medication.rawValue {
                if medicationSubCatModel[indexPath.row].isSelected {
                    self.medicalOptionsDataModel?.subCategoryList[indexPath.row].isSelected = false
                } else {
                    self.medicalOptionsDataModel?.subCategoryList[indexPath.row].isSelected = true
                }
            } else {
                for (subCatIndex , _) in medicationSubCatModel.enumerated() {
                    if subCatIndex == indexPath.row {
                        self.medicalOptionsDataModel?.subCategoryList[subCatIndex].isSelected = true
                    } else {
                        self.medicalOptionsDataModel?.subCategoryList[subCatIndex].isSelected = false
                    }
                }

            }


            self.collectionViewSubcategory.reloadData()
        }
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
