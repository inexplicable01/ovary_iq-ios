//
//  FirstDayPeriodDuration.swift
//  OvaryIQ
//
//  Created by Mobcoder on 20/01/22.
//

import UIKit

class FirstDayPeriodDuration: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var btnSubmit: UIButton!
    // MARK: - Properties
    // MARK: - view life cycle Functions
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
    
    // MARK: - Private Functions
    private func initialSetup() {
        self.view.showLoader()
        self.btnSubmit.applyGradient(colors: [UIColor(red: 255.0 / 255.0, green: 109.0 / 255.0, blue: 147.0 / 255.0, alpha: 1.0).cgColor, UIColor(red: 253.0 / 255.0, green: 147.0 / 255.0, blue: 167.0 / 255.0, alpha: 1.0).cgColor])
    }

    // MARK: - Button Actions

    @IBAction private func tapBtnSubmit(_ sender: UIButton) {
        fLog()
    }

    @IBAction private func tapBtnNotRemember(_ sender: UIButton) {
        fLog()
    }

    @IBAction private func tapBtnBack(_ sender: UIButton) {
        fLog()
    }

}
