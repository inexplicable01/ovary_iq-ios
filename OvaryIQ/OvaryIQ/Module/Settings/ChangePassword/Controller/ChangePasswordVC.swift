//
//  ChangePasswordVC.swift
//  OvaryIQ
//
//  Created by Mobcoder on 25/02/22.
//

import UIKit

class ChangePasswordVC: BaseViewC {
    // MARK: - IBOutlets
    @IBOutlet private weak var txtfieldCurrentPassword: UITextField!
    @IBOutlet private weak var txtfieldNewPassword: UITextField!
    @IBOutlet private weak var txtfieldConfirmPassword: UITextField!
    // MARK: - Properties
    private var viewModel = ChangePasswordViewModel()
    internal var goBackToAppSettingCOntroller: ((Bool) -> Void)?
    // MARK: - View Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initalSetup()
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
    // MARK: - Notifications Functions
    // MARK: - Private Functions
    private func initalSetup() {
        self.txtfieldCurrentPassword.delegate = self
        self.txtfieldNewPassword.delegate = self
        self.txtfieldConfirmPassword.delegate = self
        self.viewModel.delegate = self
    }
    // MARK: - Button Actions
    @IBAction private func tapBtncrosss(_ sender: Any) {
        fLog()
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction private func tapBtnSaveChanges(_ sender: UIButton) {
        fLog()
        let currentPassword = self.viewModel.changePasswordRequestModel.currentPassword
        let newPassword = self.viewModel.changePasswordRequestModel.password
        let confirmPassword = self.viewModel.changePasswordRequestModel.confirmPassword
        if currentPassword.isEmpty {
            AlertControllerManager.showToast(message: ErrorMessages.emptyCurrentPassword.localizedString, type: .error)
        } else if newPassword.isEmpty {
            AlertControllerManager.showToast(message: ErrorMessages.emptyNewPassword.localizedString, type: .error)
        } else if !(newPassword.isValidPassword()) {
            AlertControllerManager.showToast(message: ErrorMessages.invalidPassword.localizedString, type: .error)
        } else if confirmPassword.isEmpty {
            AlertControllerManager.showToast(message: ErrorMessages.emptyConfirmPassword.localizedString, type: .error)
        } else if newPassword != confirmPassword {
            AlertControllerManager.showToast(message: ErrorMessages.passwordDoesNotMatch.localizedString, type: .error)
        } else {
            self.viewModel.callApiToChangePassword()
       }
    }

    @IBAction private func tapBtnEyeCurrentPassword(_ sender: UIButton) {
        fLog()
        txtfieldCurrentPassword.isSecureTextEntry = sender.isSelected
        sender.isSelected = !sender.isSelected
    }

    @IBAction private func tapBtnEyeNewPassword(_ sender: UIButton) {
        fLog()
        txtfieldNewPassword.isSecureTextEntry = sender.isSelected
        sender.isSelected = !sender.isSelected
    }

    @IBAction private func tapBtnEyeConfirmPassword(_ sender: UIButton) {
        fLog()
        txtfieldConfirmPassword.isSecureTextEntry = sender.isSelected
        sender.isSelected = !sender.isSelected
    }
}
// MARK: - UITextFieldDelegate

extension ChangePasswordVC: UITextFieldDelegate {

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
        if textField == self.txtfieldCurrentPassword {
            self.viewModel.changePasswordRequestModel.currentPassword = finalText.removeWhiteSpacesAndNewLines()
        } else if textField == self.txtfieldNewPassword {
            self.viewModel.changePasswordRequestModel.password = finalText.removeWhiteSpacesAndNewLines()
        } else if textField == self.txtfieldConfirmPassword {
            self.viewModel.changePasswordRequestModel.confirmPassword = finalText.removeWhiteSpacesAndNewLines()
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
extension ChangePasswordVC: ChangePasswordViewModelDelegate {
    func sucessChangePasswordApiResponse() {
        self.dismiss(animated: true) {
            self.goBackToAppSettingCOntroller!(true)
        }
    }
}
