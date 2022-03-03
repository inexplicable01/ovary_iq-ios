//
//  ProfileVC.swift
//  OvaryIQ
//
//  Created by Mobcoder on 23/02/22.
//

import UIKit
struct Profile {
    var title: String?
    var img: UIImage?
    var isHideGreyLine: Bool?
    var controller: String?
    init(title: String, img: UIImage, isHideGreyLine: Bool,controller: String) {
        self.title = title
        self.img = img
        self.isHideGreyLine = isHideGreyLine
        self.controller = controller
    }
}
class SideOptionsVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var profileTableView: UITableView!
    @IBOutlet private weak var btnLogout: UIButton!
    // MARK: - Properties
    private var viewModel = SideOptionsViewModel()
    private var profileArr = [Profile(title: "My Profile", img: UIImage(named: "myProfile")!, isHideGreyLine: false, controller: MyProfileVC.className), Profile(title: "Settings", img: UIImage(named: "settings")!, isHideGreyLine: true, controller: SettingVC.className)]

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

    // MARK: - Private Functions
    private func initialSetup() {
        self.btnLogout.applyGradient(colors: [UIColor(red: 255.0 / 255.0, green: 109.0 / 255.0, blue: 147.0 / 255.0, alpha: 1.0).cgColor, UIColor(red: 253.0 / 255.0, green: 147.0 / 255.0, blue: 167.0 / 255.0, alpha: 1.0).cgColor])
   }
    // MARK: - Button Actions
    @IBAction private func tapBtnCross(_ sender: UIButton) {
        fLog()
        self.navigationController?.popViewController(animated: false)
    }

    @IBAction private func tapBtnLogout(_ sender: Any) {
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

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SideOptionsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.profileArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: SideOptionsTVC.className, for: indexPath) as? SideOptionsTVC {
            cell.configCell(sideMenuOption: profileArr[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let viewController = Storyboard.Settings.instantiateViewController(identifier: profileArr[indexPath.row].controller ?? "")
            self.navigationController?.pushViewController(viewController, animated: true)
//        if indexPath.row == 0 {
//            if let myProfileVC = Storyboard.Settings.instantiateViewController(withIdentifier: MyProfileVC.className) as? MyProfileVC {
//                self.navigationController?.pushViewController(myProfileVC, animated: true)
//            }
//        } else {
//            if let settingVC = Storyboard.Settings.instantiateViewController(withIdentifier: SettingVC.className) as? SettingVC {
//                self.navigationController?.pushViewController(settingVC, animated: true)
//            }
//        }

    }
}
