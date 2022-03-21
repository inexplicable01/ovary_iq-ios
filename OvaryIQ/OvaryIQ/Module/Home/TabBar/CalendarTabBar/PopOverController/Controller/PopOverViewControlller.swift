//
//  PopOverViewControlller.swift
//  OvaryIQ
//
//  Created by Mobcoder on 15/03/22.
//

import UIKit

class PopOverViewControlller: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    // MARK: - Properties
    internal var headerArray = [SubCategoryList]()
   // MARK: - view life cycle function
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
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
       // self.viewModel.unregisterCoreEngineEventsCallBack()
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
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    // MARK: - Button Actions

}
// MARK: - UITableViewDelegate, UITableViewDataSource
extension PopOverViewControlller: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.headerArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: PopOverTVC.className, for: indexPath) as? PopOverTVC {
            cell.configCell(model: self.headerArray[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}
