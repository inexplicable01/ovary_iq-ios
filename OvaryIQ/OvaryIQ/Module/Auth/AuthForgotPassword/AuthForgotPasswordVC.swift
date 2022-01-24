//
//  AuthForgotPasswordVC.swift
//  OvaryIQ
//
//  Created by Mobcoder on 12/01/22.
//

import UIKit
class AuthForgotPasswordVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var txtFieldEmail: UITextField!
    @IBOutlet private weak var bottomView: UIView!
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
    }
    // MARK: - Button Actions
    @IBAction private func tapBtnNext(sender: UIButton) {
         fLog()
        self.dismiss(animated: true) {
            self.goBack!(true)
        }
    }

    @IBAction private func tapBtnCross(sender: UIButton) {
         fLog()
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction private func tapBtnSignUp(sender: UIButton) {
         fLog()
        let authSignUpVC = Storyboard.Auth.instantiateViewController(identifier: AuthSignUpVC.className)
        self.navigationController?.pushViewController(authSignUpVC, animated: true)
    }
}
