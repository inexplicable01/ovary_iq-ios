//
//  RegularOrIrregularCycleVC.swift
//  OvaryIQ
//
//  Created by Mobcoder on 19/01/22.
//

import UIKit
class RegularOrIrregularCycleVC: BaseViewC {
    // MARK: - IBOutlets

    @IBOutlet private weak var btnNext: UIButton!
    @IBOutlet weak var bannerPeriodTrakingStackView: UIStackView!
    @IBOutlet weak var getPreganatStackView: UIStackView!
    @IBOutlet private weak var btnRegular: UIButton!
    @IBOutlet private weak var btnIrregular: UIButton!
    @IBOutlet private weak var btnDontKnow: UIButton!
    // MARK: - Properties
    internal var tryingRegularIregulatTypeRequestModel = TryingGetPreganantRequestModel()
    internal var selectedGoalType: String?
    // MARK: - View Life Cycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        self.intialSetup()

        // Do any additional setup after loading the view.
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
    private func intialSetup() {
        if selectedGoalType == GoalType.periodTracking.rawValue{
            self.bannerPeriodTrakingStackView.isHidden = false
            self.getPreganatStackView.isHidden = true
           // self.bannerImgView.image = UIImage(named: "PeriodBanner_2")
        } else {

            self.bannerPeriodTrakingStackView.isHidden = true
            self.getPreganatStackView.isHidden = false
           // self.bannerImgView.image = UIImage(named: "banner_3")
        }
        self.changeNextBtnColor()
    }
     // MARK: - Button Actions
    @IBAction private func tapBtnRegular(_ sender: UIButton) {
        fLog()
       sender.isSelected = !sender.isSelected
        if sender.isSelected {
            self.tryingRegularIregulatTypeRequestModel.periodCycle = PeriodCycleType.regular.rawValue
            self.btnIrregular.isSelected = false
            self.btnRegular.isSelected = true
            self.btnDontKnow.isSelected = false
        } else {
            self.tryingRegularIregulatTypeRequestModel.periodCycle = ""
        }
        self.changeNextBtnColor()

    }

    private func changeNextBtnColor() {

        if self.tryingRegularIregulatTypeRequestModel.periodCycle.isEmpty {
            AppConfig.defautMainQ.async {
                self.btnNext.layer.sublayers = self.btnNext.layer.sublayers?.filter { theLayer in
                      !theLayer.isKind(of: CAGradientLayer.classForCoder())
                }
                self.btnNext.backgroundColor = UIColor(red: 253.0 / 255.0, green: 147.0 / 255.0, blue: 167.0 / 255.0, alpha: 0.5)
            }

        } else {
            self.btnNext.applyGradient(colors: [UIColor(red: 255.0 / 255.0, green: 109.0 / 255.0, blue: 147.0 / 255.0, alpha: 1.0).cgColor, UIColor(red: 253.0 / 255.0, green: 147.0 / 255.0, blue: 167.0 / 255.0, alpha: 1.0).cgColor])
        }

    }

    @IBAction private func tapBtnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction private func tapBtnIrrRegular(_ sender: UIButton) {
        fLog()
       sender.isSelected = !sender.isSelected
        if sender.isSelected {
            self.tryingRegularIregulatTypeRequestModel.periodCycle = PeriodCycleType.irregular.rawValue
            self.btnIrregular.isSelected = true
            self.btnRegular.isSelected = false
            self.btnDontKnow.isSelected = false
        } else {
            self.tryingRegularIregulatTypeRequestModel.periodCycle = ""
        }
        self.changeNextBtnColor()
    }

    @IBAction private func tapBtnDontKnow(_ sender: UIButton) {
        fLog()
       sender.isSelected = !sender.isSelected
        if sender.isSelected {
            self.tryingRegularIregulatTypeRequestModel.periodCycle = PeriodCycleType.notKnow.rawValue
            self.btnIrregular.isSelected = false
            self.btnRegular.isSelected = false
            self.btnDontKnow.isSelected = true
        } else {
            self.tryingRegularIregulatTypeRequestModel.periodCycle = ""
        }
        self.changeNextBtnColor()
    }

    @IBAction private func tapBtnNext(_ sender: UIButton) {
        if self.tryingRegularIregulatTypeRequestModel.periodCycle.isEmpty {
            AlertControllerManager.showToast(message: ErrorMessages.selectPeriodCycle.localizedString, type: .error)
        } else {
            if let periodStartDateVC = Storyboard.Questions.instantiateViewController(identifier: PeriodStartDateVC.className) as? PeriodStartDateVC {
                periodStartDateVC.selectedGoalType = self.selectedGoalType
                periodStartDateVC.tryingPeriodDetailModelrequest = self.tryingRegularIregulatTypeRequestModel
                 self.navigationController?.pushViewController(periodStartDateVC, animated: true)
            }
        }
    }
}
