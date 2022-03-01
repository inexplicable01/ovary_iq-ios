//
//  HomeVC.swift
//  OvaryIQ
//
//  Created by Mobcoder on 24/01/22.
//

import UIKit
import SwiftMessages

class HomeVC: BaseViewC {
    // MARK: - IBOutlets
    // MARK: - Properties
    private var viewModel = HomeViewModel()
    // MARK: - view life cycle function
    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.initialSetup()
       // self.viewModel.registerCoreEngineEventsCallBack()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // self.viewModel.registerCoreEngineEventsCallBack()
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
//    private func initialSetup() {
//        self.viewModel.delegate = self
//    }
    // MARK: - Button Actions
    @IBAction private func tapBtnProfile(_ sender: UIButton) {
        fLog()
           // create the alert
            let alert = UIAlertController(title: Text.appName.localizedString, message: Text.logOut.localizedString, preferredStyle: UIAlertController.Style.alert)

       // add an action (button)
            alert.addAction(UIAlertAction.init(title: Text.oks.localizedString,style: UIAlertAction.Style.default,handler: { (action) in
                self.viewModel.callApiTologout()
       }))
            alert.addAction(UIAlertAction.init(title: Text.cancel.localizedString, style: UIAlertAction.Style.default, handler: { (action) in

       }))
       self.present(alert, animated: true, completion: nil)
    }
}
