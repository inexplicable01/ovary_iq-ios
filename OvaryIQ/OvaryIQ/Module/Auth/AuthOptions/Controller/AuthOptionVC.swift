//
//  ViewController.swift
//  OvaryIQ
//
//  Created by Mobcoder on 12/01/22.
//

import UIKit

class AuthOptionVC: UIViewController {
    // MARK: - IBOutlets
    // MARK: - Properties
    private var viewModel = AuthOptionViewModel()
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
    // MARK: - Private Functions

    private func initialSetup() {
        viewModel.viewContreoller = self
        self.viewModel.delegate = self
   }

    // MARK: - Button Actions
    @IBAction private func tapBtnApple(_ sender: Any) {
        fLog()
        self.viewModel.validateSocialId(loginType: .apple)
//        let answersFewQuestionsVC = Storyboard.Questions.instantiateViewController(identifier: AnswersFewQuestionsVC.className)
//        self.navigationController?.pushViewController(answersFewQuestionsVC, animated: true)
    }

    @IBAction private func tapBtnGoogle(_ sender: Any) {
        fLog()

        self.viewModel.validateSocialId(loginType: .google)
//        GoogleManager.shared.login(viewController: self) { (socialUserInfo, message, success) in
//                    if !success {
//                       // Utility.showToast(message: message ?? "Google Login Error")
//                    } else {
//                          if let userInfo = socialUserInfo {
//                          }
//                    }
//        }
//        let answersFewQuestionsVC = Storyboard.Questions.instantiateViewController(identifier: AnswersFewQuestionsVC.className)
//        self.navigationController?.pushViewController(answersFewQuestionsVC, animated: true)
    }

    @IBAction private func tapBtnEmail(_ sender: Any) {
        fLog()
        let authLoginVC = Storyboard.Auth.instantiateViewController(identifier: AuthLoginVC.className)
        self.navigationController?.pushViewController(authLoginVC, animated: true)
    }
}
extension AuthOptionVC: AuthOptionViewModelDelegate {
    func sucessLoginSocialApiResponse() {
        if UserDefaults.IsSaveGoal == nil || UserDefaults.IsSaveGoal == "" || UserDefaults.IsSaveGoal == "False" {
                //here show answer question screen as rootviewController
                Helper.showAnswerFewQuestionsScreen()
        }else{
                //here show home screen as rootviewController
                Helper.showHomeScreen()
        }
        //Helper.showAnswerFewQuestionsScreen()
    }

}
