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
    @IBOutlet private weak var lblTitle: UILabel!

    // MARK: - Properties
    internal var goBack: ((Bool, String) -> Void)?
    internal var otpCode: String = ""
    private var viewModel = AuthVerificationViewModel()
    private var fourDigitCode = ""
    private var counter = 60
    private var timerTest: Timer?
    internal var resentOtpRequestModel = ForgotPasswordRequestModel()
    private var resentOtpViewModel = ForgotPasswordViewModel()
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
        self.stopTimerTest()
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
        self.lblTitle.text = "Enter the 4-digit verification code emailed to \(self.resentOtpRequestModel.email)"
        // For Auto Fill OTP
        if #available(iOS 12.0, *) {
            self.txtFieldOtp1.textContentType = .oneTimeCode
            self.txtFieldOtp2.textContentType = .oneTimeCode
            self.txtFieldOtp3.textContentType = .oneTimeCode
            self.txtFieldOtp4.textContentType = .oneTimeCode
        }

        self.txtFieldOtp1.becomeFirstResponder()
        self.viewModel.delegate = self
        startTimer()

    }

    private func startTimer () {
      guard timerTest == nil else { return }
      timerTest = Timer.scheduledTimer(
        timeInterval: TimeInterval(1.0),target: self,selector: #selector(Self.updateCounter),userInfo: nil,repeats: true)
    }

    private func stopTimerTest() {
        timerTest?.invalidate()
        timerTest = nil
     }

     @objc private func updateCounter() {
        if counter > -1 {
            dLog(message: "\(counter) seconds to the end of the world")
             if counter == 0 {
                self.otpCodeExipredAlert()
            }
            if counter < 10 {
                lblTime.text = "00:0\(counter)"
            }
            else {
                lblTime.text = "00:\(counter)"
            }
            counter -= 1
        }
     }
    private func otpCodeExipredAlert() {
        AlertControllerManager.showToast(message: ErrorMessages.otpcodeExipred.localizedString, type: .error)
        self.txtFieldOtp1.becomeFirstResponder()
        self.txtFieldOtp1.text = ""
        self.txtFieldOtp2.text = ""
        self.txtFieldOtp3.text = ""
        self.txtFieldOtp4.text = ""
        self.fourDigitCode = ""
        self.viewModel.authVerificationCodeRequestModel.otp = nil
        self.stopTimerTest()
    }
    // MARK: - Button Actions

    @IBAction private func tapBtnResentOtp(sender: UIButton) {
        fLog()
        self.startTimer()
        self.counter = 60
        self.txtFieldOtp1.becomeFirstResponder()
        self.resentOtpViewModel.forgotPasswordRequestModel = self.resentOtpRequestModel
        self.resentOtpViewModel.callApiToForgotPassword()
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
           self.startTimer()
           self.goBack!(true, code ?? "")
        }
    }
}
