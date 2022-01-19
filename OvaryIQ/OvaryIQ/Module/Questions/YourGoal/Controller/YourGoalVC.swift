//
//  YourGoalVC.swift
//  OvaryIQ
//
//  Created by Mobcoder on 14/01/22.
//

import UIKit
// struct goal{
//
//    var title: String?
//    var title_image = UIImage(named: "")
//
//    init(title:String,title_image: UIImage){
//        self.title = title
//        self.title_image = title_image
// }
// }
class YourGoalVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var btnNext: UIButton!
    
    // MARK: - Properties
  //  private var goalArr = ["Get pregnant","Track symptoms","Avoid pregnancy","Period tracking"]
    
    // MARK: - View Life Cycle Functions
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
        self.btnNext.applyGradient(colors: [UIColor(red: 255.0/255.0, green: 109.0/255.0, blue: 147.0/255.0, alpha: 1.0).cgColor,UIColor(red: 253.0/255.0, green: 147.0/255.0, blue: 167.0/255.0, alpha: 1.0).cgColor])
    }
    // MARK: - Button Actions
    @IBAction private func tapBtnNext(_ sender: Any) {
        fLog()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension YourGoalVC: UITableViewDelegate, UITableViewDataSource {

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }

    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        fLog()
    }

    // MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: GoalTVC = tableView.dequeueReusableCell(withIdentifier: GoalTVC.className, for: indexPath) as? GoalTVC {
          // cell.delegate = self
           // cell.configCell()
            return cell
        } else {
            return tableView.emptyCell()
        }
    }
}
