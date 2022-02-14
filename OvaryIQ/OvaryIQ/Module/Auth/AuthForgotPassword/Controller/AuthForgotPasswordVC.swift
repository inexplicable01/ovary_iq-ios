//
//  AuthForgotPasswordVC.swift
//  OvaryIQ
//
//  Created by Mobcoder on 12/01/22.
//

import UIKit
protocol AuthForgotPasswordVCDeleagte {
    func tapBtnSignup()
}

class AuthForgotPasswordVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var txtFieldEmail: UITextField!
    @IBOutlet private weak var bottomView: UIView!
    // MARK: - Properties
    internal var goBack: ((Bool,String, ForgotPasswordRequestModel) -> Void)?
    private var viewModel = ForgotPasswordViewModel()
    internal var delegate: AuthForgotPasswordVCDeleagte?
    // MARK: - View Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initalSetup()
        self.viewModel.registerCoreEngineEventsCallBack()
    }
        // Do any additional setup after loading the view.

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
    @IBAction private func tapBtnNext(sender: UIButton) {
         fLog()

        let email = self.viewModel.forgotPasswordRequestModel.email

        if email.isEmpty {
            AlertControllerManager.showToast(message: ErrorMessages.emptyEmail.localizedString, type: .error)
        } else if !(email.isValidemail()) {
            AlertControllerManager.showToast(message: ErrorMessages.invalidEmailId.localizedString, type: .error)
        } else {
            self.viewModel.callApiToForgotPassword()
        }
    }

    @IBAction private func tapBtnCross(sender: UIButton) {
         fLog()
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction private func tapBtnSignUp(sender: UIButton) {
         fLog()
        self.dismiss(animated: true) {
            self.delegate?.tapBtnSignup()
        }
    }
    
}
// MARK: - UITextFieldDelegate

extension AuthForgotPasswordVC: UITextFieldDelegate {

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
            self.viewModel.forgotPasswordRequestModel.email = finalText.removeWhiteSpacesAndNewLines()
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
extension AuthForgotPasswordVC: ForgotPasswordViewModelDelegate {
    func sucessForgotPasswordApiResponse(code: String?) {
        self.dismiss(animated: true) {
            self.goBack!(true, code ?? "", self.viewModel.forgotPasswordRequestModel)
        }
    }
}
