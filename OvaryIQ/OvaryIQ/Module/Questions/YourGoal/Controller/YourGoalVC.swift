//
//  YourGoalVC.swift
//  OvaryIQ
//
//  Created by Mobcoder on 14/01/22.
//

import UIKit
 struct Goal {
    var title: String?
    var titleImage: UIImage?
    var selectedImage: UIImage?
    var isSelected: Bool?

     init(title: String, titleImage: UIImage, selectedImage: UIImage, isSelected: Bool) {
        self.title = title
        self.titleImage = titleImage
        self.selectedImage = selectedImage
        self.isSelected = isSelected
    }
 }
class YourGoalVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var btnNext: UIButton!
    // MARK: - Properties
    private var goalArr = [Goal(title: "Get pregnant", titleImage: UIImage(named: "get_Preganent") ?? UIImage(), selectedImage: UIImage(named: "SelectedPreganent") ?? UIImage(), isSelected: false),Goal(title: "Period tracking", titleImage: UIImage(named: "unselectedPeriodTracker") ?? UIImage(), selectedImage: UIImage(named: "selectedPeriodTracker") ?? UIImage(), isSelected: true)]
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
        self.btnNext.applyGradient(colors: [UIColor(red: 255.0 / 255.0, green: 109.0 / 255.0, blue: 147.0 / 255.0, alpha: 1.0).cgColor, UIColor(red: 253.0 / 255.0, green: 147.0 / 255.0, blue: 167.0 / 255.0, alpha: 1.0).cgColor])
    }
    // MARK: - Button Actions
    @IBAction private func tapBtnNext(_ sender: Any) {
        fLog()
        let answersFewQuestionsVC = Storyboard.Questions.instantiateViewController(identifier: LogYearOfBirthVC.className)
        self.navigationController?.pushViewController(answersFewQuestionsVC, animated: true)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension YourGoalVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

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
