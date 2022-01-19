//
//  RegularOrIrregularCycleVC.swift
//  OvaryIQ
//
//  Created by Mobcoder on 19/01/22.
//

import UIKit

class RegularOrIrregularCycleVC: UIViewController {
    // MARK: - IBOutlets
    // MARK: - Properties
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

    // MARK: - Private Functions
     // MARK: - Button Actions
    @IBAction private func tapBtnRegular(_ sender: UIButton) {
        fLog()
      //  sender.isSelected = !sender.isSelecte
    }

}
