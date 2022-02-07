//
//  AuthVerificationVC.swift
//  OvaryIQ
//
//  Created by Mobcoder on 14/01/22.
//

import UIKit
class AuthVerificationCodeVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var lblTime: UILabel!
    @IBOutlet private weak var bottomView: UIView!
    @IBOutlet private weak var txtFieldOtp1: UITextField!
    @IBOutlet private weak var txtFieldOtp2: UITextField!
    @IBOutlet private weak var txtFieldOtp3: UITextField!
    @IBOutlet private weak var txtFieldOtp4: UITextField!

    // MARK: - Properties
    internal var goBack: ((Bool, String) -> Void)?
    internal var otpCode: String = ""
    private var viewModel = AuthVerificationViewModel()
    var fourDigitCode = ""
    private var counter = 60
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
        // For Auto Fill OTP
        if #available(iOS 12.0, *) {
            self.txtFieldOtp1.textContentType = .oneTimeCode
            self.txtFieldOtp2.textContentType = .oneTimeCode
            self.txtFieldOtp3.textContentType = .oneTimeCode
            self.txtFieldOtp4.textContentType = .oneTimeCode
        }
        self.txtFieldOtp1.becomeFirstResponder()
        self.viewModel.delegate = self
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
     @objc private func updateCounter() {
        if counter > 0 {
            dLog(message: "\(counter) seconds to the end of the world")
            if counter < 10 {
                lblTime.text = "00:0\(counter)"
            } else {
                lblTime.text = "00:\(counter)"
            }

            counter -= 1
        }
    }
    // MARK: - Button Actions

    @IBAction private func tapBtnResentOtp(sender: UIButton) {
        fLog()
    }

    @IBAction private func tapBtnNext(_ sender: UIButton) {
         fLog()
        if let otp1 = txtFieldOtp1.text?.removeWhiteSpacesAndNewLines() {
            self.fourDigitCode = otp1
        }
        if let otp2 = txtFieldOtp2.text?.removeWhiteSpacesAndNewLines() {
            self.fourDigitCode = "\(self.fourDigitCode)\(otp2)"
        }
        if let otp3 = txtFieldOtp3.text?.removeWhiteSpacesAndNewLines() {
            self.fourDigitCode = "\(self.fourDigitCode)\(otp3)"
        }
        if let otp4 = txtFieldOtp4.text?.removeWhiteSpacesAndNewLines() {
            self.fourDigitCode = "\(self.fourDigitCode)\(otp4)"
        }

        self.viewModel.authVerificationCodeRequestModel.otp = Int(fourDigitCode)
        let otp = "\(String(describing: self.viewModel.authVerificationCodeRequestModel.otp))"
        if otp.count < 4 {
            AlertControllerManager.showToast(message: ErrorMessages.empptyVerificationCode.localizedString, type: .error)
        } else {
            self.viewModel.callApiToVerifyOtp()
        }
    }

    @IBAction private func tapCrossBtn(sender: UIButton) {
        fLog()
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction private func textFieldEditingChanged(_ textField: UITextField) {
        fLog()

        let finalText = textField.text ?? ""
        if finalText.isEmpty {
            if textField == self.txtFieldOtp4 {
                self.txtFieldOtp3.becomeFirstResponder()
            } else if textField == self.txtFieldOtp3 {
                self.txtFieldOtp2.becomeFirstResponder()
            } else if textField == self.txtFieldOtp2 {
                self.txtFieldOtp1.becomeFirstResponder()
            } else if textField == self.txtFieldOtp1 {
                self.view.endEditing(true)
            }
        } else {
            let lastDigit = Utility.numberConversion(number: String(finalText[finalText.index(before: finalText.endIndex)]))

            if textField == self.txtFieldOtp1 {
                self.txtFieldOtp1.text = String(lastDigit)
                self.txtFieldOtp2.becomeFirstResponder()
            } else if textField == self.txtFieldOtp2 {
                self.txtFieldOtp2.text = String(lastDigit)
                self.txtFieldOtp3.becomeFirstResponder()
            } else if textField == self.txtFieldOtp3 {
                self.txtFieldOtp3.text = String(lastDigit)
                self.txtFieldOtp4.becomeFirstResponder()
            } else if textField == self.txtFieldOtp4 {
                self.txtFieldOtp4.text = String(lastDigit)
                self.view.endEditing(true)
               // self.verifyOtp()
            }
        }
    }
}
// MARK: - Protocol and delegate method
extension AuthVerificationCodeVC: AuthVerificationViewModelDelegate {
    func sucessVerificationCodeApiResponse(code: String?) {
       self.dismiss(animated: true) {
           self.goBack!(true, code ?? "")
        }
    }
}
