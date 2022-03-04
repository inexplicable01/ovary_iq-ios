//
//  MyProfileVC.swift
//  OvaryIQ
//
//  Created by Mobcoder on 25/02/22.
//

import UIKit
class MyProfileVC: BaseViewC {
    // MARK: - IBOutlets
    @IBOutlet private weak var lblName: UILabel!
    @IBOutlet private weak var lblEmail: UILabel!
    @IBOutlet private weak var lblMyStatus: UILabel!
    @IBOutlet private weak var lblPhoneNumber: UILabel!
    @IBOutlet private weak var lblAverageLifeCycle: UILabel!
    @IBOutlet private weak var lblDaysInPeriod: UILabel!
    @IBOutlet private weak var lblBirthYear: UILabel!
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
        self.viewModel.delegate = self
        self.viewModel.callApiTogetUserProfile()
    }
    private func showProfileResponse(dataModel: MyProfileDataModel) {
        self.lblName.text = dataModel.userData?.name ?? ""
        self.lblEmail.text = dataModel.userData?.email ?? ""
        self.lblPhoneNumber.text = "+\(dataModel.userData?.countryCode ?? 1) \(dataModel.userData?.mobile ?? "")"
        self.lblMyStatus.text = dataModel.userData?.userGoaldetails?.first?.goalStatus ?? ""
        self.lblBirthYear.text = "\(dataModel.userData?.userGoaldetails?.first?.birthYear ?? 0)"
        self.lblDaysInPeriod.text = dataModel.userData?.userGoaldetails?.first?.daysInPeriod ?? ""
        self.lblAverageLifeCycle.text = "\(dataModel.userData?.userGoaldetails?.first?.avgCycle ?? 0)"
    }
    // MARK: - Button Actions
    @IBAction private func tabBtnBack(_ sender: Any) {
        fLog()
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: -
extension MyProfileVC: MyProfileViewModelDelegate {
    func sucessUserProfileApiResponse(profileDataModel: MyProfileDataModel) {
        self.showProfileResponse(dataModel: profileDataModel)
    }

}
