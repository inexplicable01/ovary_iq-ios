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
    // MARK: - Properties
    // MARK: - View Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
   // MARK: - Notifications Functions
   // MARK: - Private Functions
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ProjectionsTVC.className, for: indexPath) as? ProjectionsTVC {
            return cell
        }
        return UITableViewCell()
    }
}
