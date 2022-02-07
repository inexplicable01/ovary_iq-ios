//
//  ImportantInformationVC.swift
//  OvaryIQ
//
//  Created by Mobcoder on 05/02/22.
//

import UIKit

class ImportantInformationVC: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet weak var btnOk: UIButton!
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
    // MARK: - Notifications Functions

    // MARK: - Private Functions
    // MARK: - Button Actions

    @IBAction func tapBtnOk(_ sender: Any) {
        fLog()
        self.dismiss(animated: true, completion: nil)
    }

}
