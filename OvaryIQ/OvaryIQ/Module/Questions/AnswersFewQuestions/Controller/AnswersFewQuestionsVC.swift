//
//  AnswersFewQuestionsVC.swift
//  OvaryIQ
//
//  Created by Mobcoder on 14/01/22.
//

import UIKit

class AnswersFewQuestionsVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var btnContinue: UIButton!
    // MARK: - Properties
    // MARK: - View Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetUp()
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

    // MARK: - private Functions
    private func initialSetUp() {
        self.btnContinue.applyGradient(colors: [UIColor(red: 255.0 / 255.0, green: 109.0 / 255.0, blue: 147.0 / 255.0, alpha: 1.0).cgColor, UIColor(red: 253.0 / 255.0, green: 147.0 / 255.0, blue: 167.0 / 255.0, alpha: 1.0).cgColor])
     }
    // MARK: - Button Actions
    @IBAction private func tapBtnContinue(sender: UIButton) {
        fLog()
        let answersFewQuestionsVC = Storyboard.Questions.instantiateViewController(identifier: YourGoalVC.className)
        self.navigationController?.pushViewController(answersFewQuestionsVC, animated: true)
    }

}
