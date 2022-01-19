//
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
    // MARK: - View
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
    @IBAction private func tapBtnSignUp(sender: UIButton) {
        fLog()
    }

    @IBAction private func tapBtnSubmit(sender: UIButton) {
         fLog()
    }

    @IBAction private func tapCrossBtn(sender: UIButton) {
        fLog()
    }
}
