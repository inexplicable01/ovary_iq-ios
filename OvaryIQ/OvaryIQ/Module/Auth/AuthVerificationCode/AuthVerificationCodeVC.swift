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
    internal var goBack: ((Bool) -> Void)?
    // MARK: - View Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initalSetup()
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
    }

    // MARK: - Button Actions

    @IBAction private func tapBtnResentOtp(sender: UIButton) {
        fLog()
    }

    @IBAction private func tapBtnNext(_ sender: UIButton) {
         fLog()
        self.dismiss(animated: true) {
            self.goBack!(true)
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
