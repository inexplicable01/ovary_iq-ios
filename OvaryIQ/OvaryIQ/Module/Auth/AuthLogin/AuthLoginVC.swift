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
    // MARK: - View Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
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

    // MARK: - Notifications Functions

    // MARK: - Private Functions
    private func initialSetup() {
        self.loginBtn.applyGradient(colors: [UIColor(red: 255.0 / 255.0, green: 109.0 / 255.0, blue: 147.0 / 255.0, alpha: 1.0).cgColor, UIColor(red: 253.0 / 255.0, green: 147.0 / 255.0, blue: 167.0 / 255.0, alpha: 1.0).cgColor])
    }

    // MARK: - Button Actions

    @IBAction private func tapPasswordEyeBtn(_ sender: UIButton) {
        fLog()
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
