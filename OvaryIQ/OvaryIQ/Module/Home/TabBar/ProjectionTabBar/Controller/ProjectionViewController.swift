//
//  ProjectionViewController.swift
//  OvaryIQ
//
//  Created by Mobcoder on 03/03/22.
//

import UIKit

class ProjectionViewController: BaseViewC {
    // MARK: - IBOutlets
    @IBOutlet private weak var tablViewProjections: UITableView!
    @IBOutlet private weak var imgViewProfileimg: UIImageView!
    // MARK: - Properties
    private var viewModel = ProjectionViewModel()
    private var projectionDataModel: ProjectionDataModel?
    // MARK: - View Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.initalSetup()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.registerCoreEngineEventsCallBack()
        self.initalSetup()
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
    private func initalSetup() {
        if let url = URL(string: UserDefaults.ProfilePhoto) {
            self.imgViewProfileimg.kf.setImage(with: url, placeholder: UIImage(named: UIImageType.profilePlaceholder.rawValue))
        }
        self.viewModel.delegate = self
        self.viewModel.callApiToGetProjectionData()
    }
   // MARK: - Button Actions

    @IBAction private func tapBtnProfile(_ sender: Any) {
        fLog()
        if let profileVC = Storyboard.Settings.instantiateViewController(identifier: SideOptionsVC.className) as? SideOptionsVC {
             self.navigationController?.pushViewController(profileVC, animated: true)
        }
    }

}
// MARK: - UITableViewDelegate, UITableViewDataSource
extension ProjectionViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {

        if self.projectionDataModel == nil {
            tablViewProjections.setNoDataMessage("No data found", txtColor: .gray)
           return 0
        } else{
            tablViewProjections.backgroundView = nil
           return 1
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ProjectionsTVC.className, for: indexPath) as? ProjectionsTVC {
            cell.configCell(model: self.projectionDataModel)
            return cell
        }
        return UITableViewCell()
    }
}
extension ProjectionViewController: ProjectionViewModelDelegate {
    func sucessProjectionApiResponse(projectionDataMod: ProjectionDataModel) {
        self.projectionDataModel = projectionDataMod
        self.tablViewProjections.reloadData()
    }
}
