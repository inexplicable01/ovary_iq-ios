
//  ResetPasswordVC.swift
//  OvaryIQ
//
//  Created by Mobcoder on 12/01/22.
//

import UIKit

class ResetPasswordVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var bottomView: UIView!
    @IBOutlet private weak var newPasswordTxtfield: UITextField!
    @IBOutlet private weak var confirmPasswordTxtfield: UITextField!
    // MARK: - Properties
    internal var goBack: ((Bool) -> Void)?
    internal var code: String = ""
    private var viewModel = ResetPasswordViewModel()
    // MARK: - View Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initalSetup()
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
    private func initalSetup() {
        self.bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top right corner, Top left corner respectively
        self.viewModel.delegate = self
    }

    // MARK: - Button Actions
    @IBAction private func tapBtnSignUp(sender: UIButton) {
        fLog()
        let authSignUpVC = Storyboard.Auth.instantiateViewController(identifier: AuthSignUpVC.className)
        self.navigationController?.pushViewController(authSignUpVC, animated: true)
    }

    @IBAction private func tapBtnSubmit(sender: UIButton) {
         fLog()

        let newPassword = self.viewModel.resetPasswordRequestModel.newPassword
        let confirmPassword = self.viewModel.resetPasswordRequestModel.confirmPassword
        self.viewModel.resetPasswordRequestModel.otpCode = code

        if newPassword.isEmpty {
            AlertControllerManager.showToast(message: ErrorMessages.emptyPassword.localizedString, type: .error)
        } else if !(newPassword.isValidPassword()) {
            AlertControllerManager.showToast(message: ErrorMessages.invalidPassword.localizedString, type: .error)
        } else if confirmPassword.isEmpty {
            AlertControllerManager.showToast(message: ErrorMessages.emptyConfirmPassword.localizedString, type: .error)
        } else if newPassword != confirmPassword {
            AlertControllerManager.showToast(message: ErrorMessages.passwordDoesNotMatch.localizedString, type: .error)
        } else {
            self.viewModel.callApiToResetPassword()
       }
    }

    @IBAction private func tapBtnEyePassword(_ sender: UIButton) {
        fLog()
        newPasswordTxtfield.isSecureTextEntry = sender.isSelected
        sender.isSelected = !sender.isSelected
    }

    @IBAction private func tapBtnEyeConfirmPassword(_ sender: UIButton) {
        fLog()
        confirmPasswordTxtfield.isSecureTextEntry = sender.isSelected
        sender.isSelected = !sender.isSelected
    }


    @IBAction private func tapCrossBtn(sender: UIButton) {
        fLog()
        self.dismiss(animated: true, completion: nil)
    }
}
// MARK: - UITextFieldDelegate

extension ResetPasswordVC: UITextFieldDelegate {

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
        if textField == self.newPasswordTxtfield {
            self.viewModel.resetPasswordRequestModel.newPassword = finalText.removeWhiteSpacesAndNewLines()
        } else if textField == self.confirmPasswordTxtfield {
            self.viewModel.resetPasswordRequestModel.confirmPassword = finalText.removeWhiteSpacesAndNewLines()
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
extension ResetPasswordVC: ResetPasswordViewModelDelegate {
    func sucessResetPasswordApiResponse() {
        self.dismiss(animated: true) {
            self.goBack!(true)
        }
    }
}
