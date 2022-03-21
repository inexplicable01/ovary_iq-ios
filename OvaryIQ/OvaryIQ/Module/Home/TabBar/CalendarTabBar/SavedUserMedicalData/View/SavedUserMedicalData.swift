//
//  SavedUserMedicalData.swift
//  OvaryIQ
//
//  Created by Mobcoder on 09/03/22.
//

import Foundation
import UIKit
protocol SavedUserMedicalDataDelegate {
    func didSelectMethodCalled(sender: UIView, subCategoaryModel: [SubCategoryList])
}
class SavedUserMedicalData: UIView {
    // MARK: - IBOutlets
    @IBOutlet internal weak var lblDate: UILabel!
    @IBOutlet private weak var imgViewBlood: UIImageView!
    @IBOutlet internal weak var xibBgView: UIView!
    @IBOutlet internal weak var collectionViewMedicationIcon: UICollectionView!
    // MARK: - Properties
    private var categories = [String]()
    internal var isChangedCollectionIconColor: Bool = false {
        didSet {
            collectionViewMedicationIcon.reloadData()
        }
    }
    internal var isZoom : Bool = false {
        didSet {
            if isZoom {
                lblDate.text = Helper.convertDateFormat(InputDateFormat: DateFormat.yearMonthDate.rawValue, OutputDateFormate: DateFormat.monthDate.rawValue, date: dateStr ?? "")
               // imgViewBlood.isHidden = true


            } else {
               // imgViewBlood.isHidden = false
                lblDate.text = "\(Helper.convertDateFormat(InputDateFormat: DateFormat.yearMonthDate.rawValue, OutputDateFormate: DateFormat.day.rawValue, date: dateStr ?? ""))         "
            }
            self.collectionViewMedicationIcon.reloadData()
        }
    }
    internal var delegate: SavedUserMedicalDataDelegate?
  //  internal var medicalOptionsListDataModel = [MedicalOptionsList]()
    internal var medicalOptionSubCategoryListArr = [SubCategoryList]() {
        didSet {
            categories.removeAll()
            categories = medicalOptionSubCategoryListArr.map({$0.categoryImage ?? ""}).unique
            collectionViewMedicationIcon.reloadData()
        }
    }
    internal var dateStr: String? {
        didSet {

            lblDate.text = "\(Helper.convertDateFormat(InputDateFormat: DateFormat.yearMonthDate.rawValue, OutputDateFormate: DateFormat.day.rawValue, date: dateStr ?? ""))         "
        }
    }

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
            addSubview(xibBgView)
           xibBgView.frame = frame
           xibBgView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
           //collectionViewMedicationIcon.frame = self.frame
            initCollectionView()
        }

        private func initCollectionView() {
            let nib = UINib(nibName: SavedMedicationsDataIconCVC.className, bundle: nil)
            collectionViewMedicationIcon.register(nib, forCellWithReuseIdentifier: SavedMedicationsDataIconCVC.className)
            collectionViewMedicationIcon.dataSource = self
            collectionViewMedicationIcon.delegate = self
        }

}
// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension SavedUserMedicalData: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let iconName = categories[indexPath.row]
        if self.categories[indexPath.row] == UIImageType.regularBledding.rawValue {
            //self.imgViewBlood.isHidden = false
        } else {
            let filterSubCategoryDataModel = self.medicalOptionSubCategoryListArr.filter({$0.categoryImage ?? "" == iconName})
            self.delegate?.didSelectMethodCalled(sender: self, subCategoaryModel: filterSubCategoryDataModel)
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

    }

    // MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if let cell: SavedMedicationsDataIconCVC = collectionViewMedicationIcon.dequeueReusableCell(withReuseIdentifier: SavedMedicationsDataIconCVC.className, for: indexPath) as? SavedMedicationsDataIconCVC {
                if self.categories[indexPath.row] == UIImageType.regularBledding.rawValue  && !(self.isZoom) {
                    self.imgViewBlood.isHidden = false
                } else {
                    self.imgViewBlood.isHidden = true
                }
                if isChangedCollectionIconColor {
                    cell.medicalOptionsImage.tintColor = .white
                } else {
                    cell.medicalOptionsImage.tintColor = .clear
                }
                if self.isZoom {
                    cell.medicalOptionsImage.isHidden = false
                } else {
                    cell.medicalOptionsImage.isHidden = self.categories[indexPath.row] == UIImageType.regularBledding.rawValue ? true : false
                }
                cell.configCell(model: self.categories[indexPath.row], isRenderImage: self.isChangedCollectionIconColor)
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

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionViewMedicationIcon.frame.size.width / 2) - 3)
        print("Collection View Width...", collectionViewMedicationIcon.width)
        return CGSize(width: width, height: width)
    }

}
