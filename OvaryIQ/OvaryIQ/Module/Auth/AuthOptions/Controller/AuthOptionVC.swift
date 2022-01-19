//
//  ViewController.swift
//  OvaryIQ
//
//  Created by Mobcoder on 12/01/22.
//

import UIKit

class AuthOptionVC: UIViewController {
    // MARK: - IBOutlets
    // MARK: - View Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
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

    // MARK: - Button Actions
    @IBAction private func tapBtnApple(_ sender: Any) {
        fLog()
        let answersFewQuestionsVC = Storyboard.Questions.instantiateViewController(identifier: AnswersFewQuestionsVC.className)
        self.navigationController?.pushViewController(answersFewQuestionsVC, animated: true)
    }

    @IBAction private func tapBtnGoogle(_ sender: Any) {
        fLog()
        let answersFewQuestionsVC = Storyboard.Questions.instantiateViewController(identifier: AnswersFewQuestionsVC.className)
        self.navigationController?.pushViewController(answersFewQuestionsVC, animated: true)
    }

    @IBAction private func tapBtnEmail(_ sender: Any) {
        fLog()
        let authLoginVC = Storyboard.Auth.instantiateViewController(identifier: AuthLoginVC.className)
        self.navigationController?.pushViewController(authLoginVC, animated: true)
    }
}
