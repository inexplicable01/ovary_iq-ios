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
    internal var previousSelectedIds = [Int]()
    internal var saveMedicationRequestModel = SaveMedicationRequestModel()
    internal var medicationModel = [MedicationModel]()
    internal var userMedicalOptionsListDataModel: MedicalOptionsList?
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
        initCollectionView()
    }

    // MARK: - Private and Internal Functions
    private func initCollectionView() {
        collectionViewSubcategory.register(UINib(nibName: String(describing: LogPeriodHeader.className), bundle: .main),
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: String(describing: LogPeriodHeader.className))
        self.collectionViewSubcategory.delegate = self
        self.collectionViewSubcategory.dataSource = self
    }

    // MARK: - Button Actions
    @IBAction private func tapBtnCross(_ sender: UIButton) {
        fLog()
        self.dismiss(animated: true, completion: nil)

    }
    @IBAction private func tapBtnTick(_ sender: UIButton) {
        fLog()
        self.dismiss(animated: true) {
            let selectedPeriodSubType = self.medicalOptionsDataModel?.subCategoryList.filter({$0.isSelected == true})
            if self.selectedDate.isEmpty {
                AlertControllerManager.showToast(message: ErrorMessages.selectPeriodStartDate.localizedString, type: .error)
            } else if selectedPeriodSubType?.isEmpty ?? false{
                AlertControllerManager.showToast(message: ErrorMessages.emptySelectPeriodSubType.localizedString, type: .error)
            }
            else {
                if let categoryModel = self.medicalOptionsDataModel?.subCategoryList {
                    self.selectedIds.removeAll()
                   // if self.selectedDate

                    if self.medicalOptionsDataModel?.name == LogPeriodCategoryType.procedure.rawValue {
                         // for procedure we don't need previous ids and date
                    } else {
                    let newMedicationModel = self.userMedicalOptionsListDataModel?.subCategoryList.filter({$0.date != self.selectedDate})
                    let userSelectedAllDates = newMedicationModel?.map({$0.date}).unique
                    if let previousDate = userSelectedAllDates {
                        for inx in 0..<previousDate.count {
                            let model = newMedicationModel?.filter({$0.date == previousDate[inx]})
                            switch self.medicalOptionsDataModel?.name {
                            case LogPeriodCategoryType.medication.rawValue:
                                    if let ids = model?.map({$0.medicationID}) {
                                        self.previousSelectedIds = ids.compactMap { Int($0 ?? "0") }
                                    }
//                            case LogPeriodCategoryType.procedure.rawValue:
//                                    if let ids = model?.map({$0.procedureID}) {
//                                        self.previousSelectedIds = ids.compactMap { Int($0 ?? "0") }
//                                    }
                            case LogPeriodCategoryType.activity.rawValue:
                                    if let ids = model?.map({$0.activityID}) {
                                        self.previousSelectedIds = ids.compactMap { Int($0 ?? "0") }
                                    }
                            case LogPeriodCategoryType.symptoms.rawValue:
                                    if let ids = model?.map({$0.symptomID}) {
                                        self.previousSelectedIds = ids.compactMap { Int($0 ?? "0") }
                                    }
                            case LogPeriodCategoryType.pregnancyTest.rawValue:
                                    if let ids = model?.map({$0.pregnancyTestID}) {
                                        self.previousSelectedIds = ids.compactMap { Int($0 ?? "0") }
                                    }
                            default:
                                    break
                            }
                            self.medicationModel.append(MedicationModel(id: self.previousSelectedIds, date: previousDate[inx] ?? ""))
                        }
                    }

                }
                    for ( _ ,mod) in categoryModel.enumerated() {
                        if mod.isSelected ?? false {
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
            if self.medicalOptionsDataModel?.name == LogPeriodCategoryType.logPeriod.rawValue  || self.medicalOptionsDataModel?.name == LogPeriodCategoryType.procedure.rawValue {

                for (subCatIndex, _) in medicationSubCatModel.enumerated() {
                    if subCatIndex == indexPath.row {
                        self.medicalOptionsDataModel?.subCategoryList[subCatIndex].isSelected = true
                    } else {
                        self.medicalOptionsDataModel?.subCategoryList[subCatIndex].isSelected = false
                    }
                }
//                if medicationSubCatModel[indexPath.row].isSelected ?? false {
//                    self.medicalOptionsDataModel?.subCategoryList[indexPath.row].isSelected = false
//                } else {
//                    self.medicalOptionsDataModel?.subCategoryList[indexPath.row].isSelected = true
//                }  // multi selection
            } else {

                if medicationSubCatModel[indexPath.row].isSelected ?? false {
                    self.medicalOptionsDataModel?.subCategoryList[indexPath.row].isSelected = false
                } else {
                    self.medicalOptionsDataModel?.subCategoryList[indexPath.row].isSelected = true
                }
//                for (subCatIndex, _) in medicationSubCatModel.enumerated() {
//                    if subCatIndex == indexPath.row {
//                        self.medicalOptionsDataModel?.subCategoryList[subCatIndex].isSelected = true
//                    } else {
//                        self.medicalOptionsDataModel?.subCategoryList[subCatIndex].isSelected = false
//                    }
//                } // signle selections
            }

            DispatchQueue.main.async {
                self.collectionViewSubcategory.reloadData()
            }

        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            switch kind {
            case UICollectionView.elementKindSectionHeader:

            if let header = collectionViewSubcategory.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: LogPeriodHeader.self),for: indexPath) as? LogPeriodHeader {
                header.delegate = self
                    return header
                }
            default:
                return UICollectionReusableView()
            }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if self.medicalOptionsDataModel?.name == LogPeriodCategoryType.medication.rawValue {
            return CGSize(width: 50, height: self.collectionViewSubcategory.frame.size.height)
        } else {
            return CGSize(width: 0, height: 0)
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
// MARK: - Protocol and delegate functionsd
extension LogPeriodsOptionsBottomSheetController: LogPeriodHeaderDelegate {
    func headerBtnPressed(isSelected: Bool) {
        if let medicationSubCatModel = self.medicalOptionsDataModel?.subCategoryList {
          for (subCatIndex, _) in medicationSubCatModel.enumerated() {
              self.medicalOptionsDataModel?.subCategoryList[subCatIndex].isSelected = isSelected
              self.collectionViewSubcategory.reloadData()
        }
    }
  }
}
