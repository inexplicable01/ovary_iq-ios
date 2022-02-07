//
//  AuthLoginVCViewController.swift
//  OvaryIQ
//
//  Created by Mobcoder on 12/01/22.
//

import UIKit

class AuthLoginVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var loginBtn: UIButton!
    @IBOutlet private weak var txtFieldEmail: UITextField!
    @IBOutlet private weak var txtFieldPassword: UITextField!
    @IBOutlet private weak var eyeBtn: UIButton!
    // MARK: - Properties
    private var viewModel = AuthLoginViewModel()
    // MARK: - View Life Cycle Functions
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


    // MARK: - Notifications Functions

    // MARK: - Private Functions
    private func initialSetup() {
        self.loginBtn.applyGradient(colors: [UIColor(red: 255.0 / 255.0, green: 109.0 / 255.0, blue: 147.0 / 255.0, alpha: 1.0).cgColor, UIColor(red: 253.0 / 255.0, green: 147.0 / 255.0, blue: 167.0 / 255.0, alpha: 1.0).cgColor])
        self.viewModel.delegate = self
    }

    // MARK: - Button Actions

    @IBAction private func tapPasswordEyeBtn(_ sender: UIButton) {
        fLog()
        txtFieldPassword.isSecureTextEntry = sender.isSelected
        sender.isSelected = !sender.isSelected

    }

    @IBAction private func tapForgotPasswordBtn(_ sender: Any) {
        fLog()
        if let authForgotPasswordVC = Storyboard.Auth.instantiateViewController(identifier: AuthForgotPasswordVC.className) as? AuthForgotPasswordVC {
            authForgotPasswordVC.modalPresentationStyle = .overFullScreen
            authForgotPasswordVC.goBack = { [weak self] isBool in
            if isBool {
                if let authVerificationCodeVC = Storyboard.Auth.instantiateViewController(identifier: AuthVerificationCodeVC.className) as? AuthVerificationCodeVC {
                    authVerificationCodeVC.modalPresentationStyle = .overFullScreen
                    authVerificationCodeVC.goBack = { [weak self] isBool in
                        if isBool {
                            if let resetPasswordVC = Storyboard.Auth.instantiateViewController(identifier: ResetPasswordVC.className) as? ResetPasswordVC {
                                resetPasswordVC.modalPresentationStyle = .overFullScreen
                                resetPasswordVC.goBack = { [weak self] isBool in
                                    if isBool {
                                        let loginSuccessPopUpVC = Storyboard.Questions.instantiateViewController(identifier: LoginSuccessPopUpVC.className)
                                        loginSuccessPopUpVC.modalPresentationStyle = .overFullScreen
                                        self?.present(loginSuccessPopUpVC, animated: true, completion: nil)
                                    }}
                               self?.present(resetPasswordVC, animated: true, completion: nil)

                            }
                        }}
                    self?.present(authVerificationCodeVC, animated: true, completion: nil)
                }
            }}
          self.present(authForgotPasswordVC, animated: true, completion: nil)
        }
    }

    @IBAction private func tapBtnLogin(_ sender: UIButton) {
        fLog()
        let email = self.viewModel.authLoginRequestModel.email
        let password = self.viewModel.authLoginRequestModel.password

        if email.isEmpty {
            AlertControllerManager.showToast(message: ErrorMessages.emptyEmail.localizedString, type: .error)
        } else if !(email.isValidemail()) {
            AlertControllerManager.showToast(message: ErrorMessages.invalidEmailId.localizedString, type: .error)
        } else if password.isEmpty {
            AlertControllerManager.showToast(message: ErrorMessages.emptyPassword.localizedString, type: .error)
        } else {
            self.viewModel.callApiToLogin()
       }

        //Helper.showHomeScreen()
    }

    @IBAction private func tapSignUpBtn(_ sender: Any) {
        fLog()
        let authSignUpVC = Storyboard.Auth.instantiateViewController(identifier: AuthSignUpVC.className)
        self.navigationController?.pushViewController(authSignUpVC, animated: true)
    }

    @IBAction private func tapBackBtn(_ sender: Any) {
        fLog()
        self.navigationController?.popViewController(animated: true)
    }

}
// MARK: - UITextFieldDelegate

extension AuthLoginVC: UITextFieldDelegate {

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
        if textField == self.txtFieldEmail {
            self.viewModel.authLoginRequestModel.email = finalText.removeWhiteSpacesAndNewLines()
        } else if textField == self.txtFieldPassword {
            self.viewModel.authLoginRequestModel.password = finalText.removeWhiteSpacesAndNewLines()
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
extension AuthLoginVC: LoginViewModelDelegate {
    // here after sucess response of signup we jump to answer few Questions screen
    func sucessLoginApiResponse() {
        let authSignUpVC = Storyboard.Questions.instantiateViewController(identifier: AnswersFewQuestionsVC.className)
       self.navigationController?.pushViewController(authSignUpVC, animated: true)
    }
}
