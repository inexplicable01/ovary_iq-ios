//
//  FirstDayPeriodDuration.swift
//  OvaryIQ
//
//  Created by Mobcoder on 20/01/22.
//

import UIKit

class FirstDayPeriodDuration: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var btnSubmit: UIButton!
    @IBOutlet private weak var txtFieldThirdPeriods: UITextField!
    @IBOutlet private weak var txtFieldSecondPeriods: UITextField!
    @IBOutlet weak var txtFieldFirstPeriods: UITextField!

    @IBOutlet weak var bannerImgView: UIImageView!

    // MARK: - Properties
    internal var periodIrregularDetailModelRequestModel = TryingGetPreganantRequestModel()
    private var viewModel = LastPeriodViewModel()
    // MARK: - view life cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
        self.viewModel.registerCoreEngineEventsCallBack()
       // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.registerCoreEngineEventsCallBack()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.viewModel.unregisterCoreEngineEventsCallBack()
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
        self.viewModel.unregisterCoreEngineEventsCallBack()
       classReleased()
    }

    
    // MARK: - Private Functions
    private func initialSetup() {
       // self.view.showLoader()
        self.btnSubmit.applyGradient(colors: [UIColor(red: 255.0 / 255.0, green: 109.0 / 255.0, blue: 147.0 / 255.0, alpha: 1.0).cgColor, UIColor(red: 253.0 / 255.0, green: 147.0 / 255.0, blue: 167.0 / 255.0, alpha: 1.0).cgColor])
        self.viewModel.delegate = self


        if self.periodIrregularDetailModelRequestModel.goalId == "2" {
            self.bannerImgView.image = UIImage(named: "periodBanner_3")
        } else {
            self.bannerImgView.image = UIImage(named: "banner_4")
        }
    }

    // MARK: - Button Actions

    @IBAction private func tapBtnSubmit(_ sender: UIButton) {
        fLog()
   //     self.periodIrregularDetailModelRequest.
        self.viewModel.fetchGoalRequestModel = periodIrregularDetailModelRequestModel
        self.checkValidations()
    }

    private func checkValidations() {
        fLog()
        let daysDifLastThirdPeriod = "\(String(describing: self.viewModel.fetchGoalRequestModel.daysDifLastThirdPeriod))"
        let daysDifLastSecondPeriod = "\(String(describing: self.viewModel.fetchGoalRequestModel.daysDifLastSecondPeriod))"
        let daysDifLastPeriod = "\(String(describing: self.viewModel.fetchGoalRequestModel.daysDifLastPeriod))"

        if daysDifLastThirdPeriod.isEmpty || daysDifLastThirdPeriod == "nil" {
            AlertControllerManager.showToast(message: ErrorMessages.emptyLastThirdPeriod.localizedString, type: .error)
        } else if daysDifLastSecondPeriod.isEmpty || daysDifLastSecondPeriod == "nil" {
            AlertControllerManager.showToast(message: ErrorMessages.emptyLastSecondPeriod.localizedString, type: .error)
        } else if daysDifLastPeriod.isEmpty || daysDifLastPeriod == "nil" {
            AlertControllerManager.showToast(message: ErrorMessages.empptyLastPeriod.localizedString, type: .error)
        } else {
            self.viewModel.callApiTosaveFetchGoalDetails()
       }
    }



    @IBAction private func tapBtnNotRemember(_ sender: UIButton) {
        fLog()
        if let importantInformationVC = Storyboard.Questions.instantiateViewController(identifier: ImportantInformationVC.className) as? ImportantInformationVC {
            importantInformationVC.delegate = self
            importantInformationVC.modalPresentationStyle = .overFullScreen
             self.present(importantInformationVC, animated: true, completion: nil)
        }
    }

    @IBAction private func tapBtnBack(_ sender: UIButton) {
        fLog()
        self.navigationController?.popViewController(animated: true)
    }

}
// MARK: - UITextFieldDelegate

extension FirstDayPeriodDuration: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {

    }

    func textFieldDidEndEditing(_ textField: UITextField) {

    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let finalText = currentText.replacingCharacters(in: stringRange, with: string)

        dLog(message: "Final Text :: \(finalText)")
        if textField == self.txtFieldThirdPeriods {
            self.periodIrregularDetailModelRequestModel.daysDifLastThirdPeriod = Int(finalText.removeWhiteSpacesAndNewLines())
        } else if textField == self.txtFieldSecondPeriods {
            self.periodIrregularDetailModelRequestModel.daysDifLastSecondPeriod = Int(finalText.removeWhiteSpacesAndNewLines())
        } else if textField == self.txtFieldFirstPeriods {
            self.periodIrregularDetailModelRequestModel.daysDifLastPeriod = Int(finalText.removeWhiteSpacesAndNewLines())
        }
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        fLog()
        textField.resignFirstResponder()
        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
}

// MARK: - Protocol and delegate method
extension FirstDayPeriodDuration: LastPeriodViewModelDelegate,ImportantInformationVCDeleagte {
    func goBackAfterDismissThisController(isDismiss: Bool) {
        self.viewModel.fetchGoalRequestModel = periodIrregularDetailModelRequestModel
        self.viewModel.callApiTosaveFetchGoalDetails()
    }

    func sucesssSaveGoalsApiResponse() {
        Helper.showHomeScreen()

    }
}
