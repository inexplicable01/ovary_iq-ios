//
//  LogYearOfBirthVC.swift
//  OvaryIQ
//
//  Created by Mobcoder on 19/01/22.
//

import UIKit

class LogYearOfBirthVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var pickerView: UIPickerView!
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var btnNext: UIButton!

    @IBOutlet private weak var bannerImgView: UIImageView!
    internal var selectedGoalId: Int?
    internal var tryingPregantYearModelRequest = TryingGetPreganantRequestModel()
    // MARK: - Properties
   // private var pickerData: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    private var pickerLabel = UILabel()
    private var selectedIndex: Int = 5
    private var isYearSelected: Bool = false
    private var pickerData: [String] {
        let currentYear = Calendar.current.component(.year, from: Date())
        var years = [String]()
        for indx in (1922...currentYear) {
            years.append("\(indx)")
        }
        return years
    }
    // MARK: - view life cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    deinit {
       classReleased()
    }

    // MARK: - Private Functions
    private func initialSetup() {

        self.btnNext.applyGradient(colors: [UIColor(red: 255.0 / 255.0, green: 109.0 / 255.0, blue: 147.0 / 255.0, alpha: 1.0).cgColor, UIColor(red: 253.0 / 255.0, green: 147.0 / 255.0, blue: 167.0 / 255.0, alpha: 1.0).cgColor])
        pickerView.selectRow(selectedIndex, inComponent: 0, animated: true)
        pickerView.inputView?.backgroundColor = .clear
        if #available(iOS 14.0, *) {
            pickerView.subviews.first?.backgroundColor = .clear
        } else {
            pickerView.subviews.forEach({
                $0.isHidden = $0.frame.height < 1.0
            })
        }
        if selectedGoalId == 2 {
            self.bannerImgView.image = UIImage(named: "periodBanner")
        } else {
            self.bannerImgView.image = UIImage(named: "banner_2")
        }
    }

    // MARK: - Button Actions
    @IBAction private func tapNextBtn(_ sender: UIButton) {
        fLog()
        self.tryingPregantYearModelRequest.birthYear = self.pickerData[self.selectedIndex]
        if isYearSelected == false {
            AlertControllerManager.showToast(message: ErrorMessages.logYourBirth.localizedString, type: .error)
        } else {
            if let id = selectedGoalId {
                self.tryingPregantYearModelRequest.goalId = "\(id)"
            }
           // self.tryingPregantYearModelRequest.birthYear = self.pickerData[self.selectedIndex]
            if let regularOrIrregularCycleVC = Storyboard.Questions.instantiateViewController(identifier: RegularOrIrregularCycleVC.className) as? RegularOrIrregularCycleVC {
                regularOrIrregularCycleVC.tryingRegularIregulatTypeRequestModel = self.tryingPregantYearModelRequest
                 self.navigationController?.pushViewController(regularOrIrregularCycleVC, animated: true)
            }
        }

    }
    @IBAction private func tapBtnBack(_ sender: Any) {
        fLog()
        self.navigationController?.popViewController(animated: true)
    }
}
// MARK: - UIPickerDelegate, UIPickerDataSource

extension LogYearOfBirthVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print("pickerDataRow...", pickerData[row])
        return pickerData[row]
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if #available(iOS 14.0, *) {
            pickerView.subviews[1].backgroundColor = .clear } else {
                pickerView.subviews.forEach({
                    $0.isHidden = $0.frame.height < 1.0
                })
         }
        pickerLabel.font = UIFont(name: "SourceSansPro-Bold", size: 22.0)
        let rowSize = pickerView.rowSize(forComponent: component)
        pickerLabel = .init(frame: CGRect(x: 0, y: 0, width: rowSize.height, height: rowSize.height))
        pickerLabel.textColor = UIColor.black
        pickerLabel.layer.cornerRadius = rowSize.height / 2
        pickerLabel.layer.masksToBounds = true
        pickerLabel.textAlignment = .center
        pickerLabel.center = CGPoint(x: pickerView.frame.size.width / 2,
                                     y: pickerView.frame.size.height / 2)
        if isYearSelected == false {
            if row == 5 {
                pickerLabel.text = "SELECT"
            } else {
                pickerLabel.text = pickerData[row]
            }

        } else {
            pickerLabel.text = pickerData[row]
        }

        if selectedIndex == row {
            pickerLabel.backgroundColor = UIColor(red: 236.0 / 255.0, green: 220.0 / 255.0, blue: 224.0 / 255.0, alpha: 1.0)
        } else {
            pickerLabel.backgroundColor = UIColor.clear
        }
        return pickerLabel
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        isYearSelected = true
//        if isYearSelected == false {
//            isYearSelected = true
//        } else {
//            if  self.tryingPregantYearModelRequest.birthYear == nil ||  (self.tryingPregantYearModelRequest.birthYear ?? "") == "" {
//                isYearSelected = false
//            } else {
//                isYearSelected = true
//            }
//
//        }
        selectedIndex = row
        self.pickerView.reloadAllComponents()

    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100
    }
}
