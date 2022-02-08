//
//  RegularOrIrregularCycleVC.swift
//  OvaryIQ
//
//  Created by Mobcoder on 19/01/22.
//

import UIKit
import FSCalendar

class RegularOrIrregularCycleVC: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet private weak var btnNext: UIButton!
    @IBOutlet private weak var bannerImgView: UIImageView!
    @IBOutlet private weak var btnRegular: UIButton!
    @IBOutlet private weak var btnIrregular: UIButton!
    @IBOutlet private weak var btnDontKnow: UIButton!
    // MARK: - Properties
    internal var tryingRegularIregulatTypeRequestModel = TryingGetPreganantRequestModel()
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
        if self.tryingRegularIregulatTypeRequestModel.goalId == "2" {
            self.bannerImgView.image = UIImage(named: "PeriodBanner_2")
        } else {
            self.bannerImgView.image = UIImage(named: "banner_3")
        }
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
    }

    @IBAction func tapBtnNext(_ sender: UIButton) {
        if self.tryingRegularIregulatTypeRequestModel.periodCycle.isEmpty {
            AlertControllerManager.showToast(message: ErrorMessages.selectPeriodCycle.localizedString, type: .error)
        } else {
            if let periodStartDateVC = Storyboard.Questions.instantiateViewController(identifier: PeriodStartDateVC.className) as? PeriodStartDateVC {
                periodStartDateVC.tryingPeriodDetailModelrequest = self.tryingRegularIregulatTypeRequestModel
                 self.navigationController?.pushViewController(periodStartDateVC, animated: true)
            }
        }
    }
}

