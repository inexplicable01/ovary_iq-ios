//
//  MyProfileVC.swift
//  OvaryIQ
//
//  Created by Mobcoder on 25/02/22.
//

import UIKit
class MyProfileVC: BaseViewC {
    // MARK: - IBOutlets
    // MARK: - Properties
    private var viewModel = MyProfileViewModel()
    // MARK: - View Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
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
    // MARK: - Notifications Functions
    // MARK: - Private Functions
    private func initialSetup() {
       // self.viewModel.delegate = self
        self.viewModel.callApiTogetUserProfile()
    }
    // MARK: - Button Actions
    @IBAction private func tabBtnBack(_ sender: Any) {
        fLog()
        self.navigationController?.popViewController(animated: true)
    }
}
