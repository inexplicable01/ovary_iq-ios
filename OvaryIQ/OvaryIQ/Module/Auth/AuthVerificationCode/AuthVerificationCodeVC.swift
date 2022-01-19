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

    @IBAction private func tapBtnResentOtp(sender: UIButton) {
        fLog()
    }
    
    @IBAction private func tapBtnNext(_ sender: UIButton) {
         fLog()
    }

    @IBAction private func tapCrossBtn(sender: UIButton) {
        fLog()
    }
}
