//
//  SettingVC.swift
//  OvaryIQ
//
//  Created by Mobcoder on 02/03/22.
//

import UIKit

class SettingVC: BaseViewC {
    // MARK: - IBOutlets
    // MARK: - Properties
    // MARK: - View Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    // MARK: - Notifications Functions
    // MARK: - Private Functions
    // MARK: - Button Actions
    @IBAction private func tapBtnBack(_ sender: Any) {
        fLog()
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction private func tapBtnChangePassword(_ sender: UIButton) {
        fLog()
        if let changePasswordVC = Storyboard.Settings.instantiateViewController(identifier: ChangePasswordVC.className) as? ChangePasswordVC {
            changePasswordVC.modalPresentationStyle = .overFullScreen
            changePasswordVC.goBackToAppSettingCOntroller = { [weak self] isSucces in
                let loginSuccessPopUpVC = Storyboard.Questions.instantiateViewController(identifier: LoginSuccessPopUpVC.className)
                loginSuccessPopUpVC.modalPresentationStyle = .overFullScreen
                self?.present(loginSuccessPopUpVC, animated: true, completion: nil)

            }
            self.navigationController?.present(changePasswordVC, animated: false, completion: nil)
        }
    }
}
