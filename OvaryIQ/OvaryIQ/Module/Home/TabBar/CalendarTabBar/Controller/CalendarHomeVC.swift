//
//  CalendarHomeVC.swift
//  OvaryIQ
//
//  Created by Mobcoder on 24/02/22.
//

import UIKit

class CalendarHomeVC: BaseViewC {
    // MARK: - IBOutlets
    @IBOutlet private  weak var calendar: FSCalendar!
    @IBOutlet private weak var lblMonthYear: UILabel!
    @IBOutlet private weak var collectionViewPredictedPeriod: UICollectionView!
    @IBOutlet private weak var collectionViewMedication: UICollectionView!

    // MARK: - Properties
    private var selectedDates = [String]()
    private lazy var today: Date = {
        return Date()
    }()
    private lazy var dateFormatter: DateFormatter = {
           let formatter = DateFormatter()
        formatter.dateFormat = DateFormat.dayMonthYear.rawValue
           return formatter
    }()
    private var viewModel = CalendarHomeViewModel()
    // MARK: - View Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.registerCoreEngineEventsCallBack()
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
        self.calendar.appearance.titleFont = UIFont(name: "SourceSansPro-Bold", size: 16)
        self.calendarSetUp()
    }
    private func calendarSetUp() {
        let date = Date()
        let year = Calendar.current.component(.year, from: date)
        let month = Calendar.current.component(.month, from: date)
        let monthName = DateFormatter().monthSymbols[month - 1]
       // lblYear.text = "\(year)"
        lblMonthYear.text = "\(monthName) \(year)"
        lblMonthYear.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        lblMonthYear.sizeToFit()
        calendar.scrollDirection = .vertical
        calendar.delegate = self
        calendar.dataSource = self
    }
    // MARK: - Button Actions
    @IBAction private func tapBtnProfile(_ sender: UIButton) {
        fLog()
        if let profileVC = Storyboard.Settings.instantiateViewController(identifier: SideOptionsVC.className) as? SideOptionsVC {
             self.navigationController?.pushViewController(profileVC, animated: true)
        }
    }
}
//MARK: -  FSCalendarDelegate,FSCalendarDataSource
  extension CalendarHomeVC: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
       calendar.scrollDirection = .vertical
    }

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.dateFormatter.string(from: date))")
        self.selectedDates.removeAll()
        let date = self.dateFormatter.string(from: date)
        self.selectedDates.append(date)
        calendar.reloadData()
    }
}

//MARK: -  UICollectionViewDelegate, UICollectionViewDataSource
extension CalendarHomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        if collectionView == collectionViewMedication {
            return 6
        } else {
            return 8
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

       if collectionView == collectionViewMedication {
           if let cell: MedicationsOptionsCVC = collectionView.dequeueReusableCell(withReuseIdentifier: MedicationsOptionsCVC.className, for: indexPath) as? MedicationsOptionsCVC {
               return cell
           }
        } else {
            if let cell: PredictedPeriodOtionsCVC = collectionView.dequeueReusableCell(withReuseIdentifier: PredictedPeriodOtionsCVC.className, for: indexPath) as? PredictedPeriodOtionsCVC {
                return cell
            }
        }

        return UICollectionViewCell()
    }

    // MARK: - UICollectionViewDelgateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionViewMedication {
            return CGSize(width: collectionView.frame.size.width / 3.5, height: 90)
         } else {
             return CGSize(width: collectionView.frame.size.width / 3, height: 30)
         }
    }
}
