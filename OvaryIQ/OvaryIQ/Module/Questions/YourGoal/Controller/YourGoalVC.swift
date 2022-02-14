//
//  YourGoalVC.swift
//  OvaryIQ
//
//  Created by Mobcoder on 14/01/22.
//

import UIKit
class YourGoalVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var btnNext: UIButton!
    // MARK: - Properties
    private var viewModel = GoalViewModel()
    private var goalArr = [GoalTypeModel]()
    private var isSlectedGetPregnant: Bool = true
    private var pregantRequestModel = TryingGetPreganantRequestModel()
    // MARK: - View Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
        self.viewModel.registerCoreEngineEventsCallBack()

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
        self.btnNext.applyGradient(colors: [UIColor(red: 255.0 / 255.0, green: 109.0 / 255.0, blue: 147.0 / 255.0, alpha: 1.0).cgColor, UIColor(red: 253.0 / 255.0, green: 147.0 / 255.0, blue: 167.0 / 255.0, alpha: 1.0).cgColor])
        self.viewModel.delegate = self
        self.viewModel.callApiToFetchGoalResponse()
    }

    // MARK: - Button Actions
    @IBAction private func tapBtnNext(_ sender: Any) {
        fLog()
        if isSlectedGetPregnant {
            if let tryingGetPregnantVC = Storyboard.Questions.instantiateViewController(identifier: TryingGetPregnantVC.className) as? TryingGetPregnantVC {
                if let goalId = self.goalArr.filter({$0.isSelected == true}).first.map({$0.id}) {
                    tryingGetPregnantVC.selectedGoalId = goalId
                }
                self.navigationController?.pushViewController(tryingGetPregnantVC, animated: true)
            }

        } else {
           if  let logYearOfBirthVC = Storyboard.Questions.instantiateViewController(identifier: LogYearOfBirthVC.className) as? LogYearOfBirthVC {
               if let goalId = self.goalArr.filter({$0.isSelected == true}).first.map({$0.id}) {
                   logYearOfBirthVC.selectedGoalId = goalId
               }
               
               self.navigationController?.pushViewController(logYearOfBirthVC, animated: true)
            }

        }

    }

    @IBAction private func tapBtnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }

}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension YourGoalVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        isSlectedGetPregnant = indexPath.row == 0 ? true : false
        for (indx,mod) in goalArr.enumerated() {
            if indx == indexPath.row {
                self.goalArr[indx].isSelected = true
            } else {
                self.goalArr[indx].isSelected = false
            }

        }
        self.collectionView.reloadData()

    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

    }

    // MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goalArr.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            if let cell: GoalCVC = collectionView.dequeueReusableCell(withReuseIdentifier: GoalCVC.className, for: indexPath) as? GoalCVC {
                cell.configCell(model: goalArr[indexPath.row], index: indexPath.row)
                return cell
            } else {
                return UICollectionViewCell()
            }

    }

    // MARK: - UICollectionViewDelgateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width / 2
        return CGSize(width: width - 15, height: width - 15)
    }
    
}
// MARK: - Protocol and delegate method
extension YourGoalVC: GoalViewModelDelegate {
    func sucessResponseFetchGoal(dataModel: GoalDataModel?) {
        self.goalArr = dataModel?.goalType ?? []
        for (indx, _) in goalArr.enumerated() {
            if indx == 0 {
                self.goalArr[indx].isSelected = true
            } else {
                self.goalArr[indx].isSelected = false
            }
        }

        self.collectionView.reloadData()

    }

}
