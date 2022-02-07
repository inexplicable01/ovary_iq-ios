//
//  PeriodStartDateVC.swift
//  OvaryIQ
//
//  Created by Mobcoder on 19/01/22.
//

import UIKit
import FSCalendar

class PeriodStartDateVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var lblYear: UILabel!
    @IBOutlet private weak var lblMonthYear: UILabel!
    @IBOutlet private weak var calendar: FSCalendar!
    @IBOutlet private weak var btnSave: UIButton!
    @IBOutlet private weak var viewyearAndMonth: UIView!
    @IBOutlet private weak var viewSide: UIView!
    // MARK: - Properties
    private var currentPage: Date?
    private lazy var today: Date = {
        return Date()
    }()
    private lazy var dateFormatter: DateFormatter = {
           let formatter = DateFormatter()
           formatter.dateFormat = "dd"
           return formatter
    }()
    private var selectedPeriodStartDate: Int?
    internal var tryingPeriodDetailModelrequest = TryingGetPreganantRequestModel()

    // MARK: - view life cycle function
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
     self.btnSave.applyGradient(colors: [UIColor(red: 255.0 / 255.0, green: 109.0 / 255.0, blue: 147.0 / 255.0, alpha: 1.0).cgColor, UIColor(red: 253.0 / 255.0, green: 147.0 / 255.0, blue: 167.0 / 255.0, alpha: 1.0).cgColor])
        self.viewyearAndMonth.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top right corner, Top left corner respectively
        self.viewSide.layer.maskedCorners = [.layerMaxXMaxYCorner,
                                             .layerMaxXMinYCorner]
     self.calendar.appearance.titleFont = UIFont(name: "SourceSansPro-Bold", size: 16)
        self.calendarSetUp()
        self.selectedPeriodStartDate = Int(self.dateFormatter.string(from: Date()))
    }

    private func calendarSetUp() {
        let date = Date()
        let year = Calendar.current.component(.year, from: date)
        let month = Calendar.current.component(.month, from: date)
        let monthName = DateFormatter().monthSymbols[month - 1]
        lblYear.text = "\(year)"
        lblMonthYear.text = "\(monthName) \(year)"
        lblMonthYear.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        lblMonthYear.sizeToFit()
        calendar.scrollDirection = .vertical
        calendar.delegate = self
      //  self.calendar.backgroundColor = UIColor(red: 253.0 / 255.0, green: 245.0 / 255.0, blue: 247.0 / 255.0, alpha: 1.0)
    }
    internal func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("change calendar ")
        let currentPageDate = calendar.currentPage
        let month = Calendar.current.component(.month, from: currentPageDate)
        let year = Calendar.current.component(.year, from: currentPageDate)
        let monthName = DateFormatter().monthSymbols[month - 1]
       // print("monthName:- ",monthName)
        lblMonthYear.text = "\(monthName) \(String(describing: year))"
        lblYear.text = "\(year)"
    }

    private func moveCurrentPage(moveUp: Bool) {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = moveUp ? 1 : -1
        self.currentPage = calendar.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
        self.calendar.setCurrentPage(self.currentPage!, animated: true)
        let values = Calendar.current.dateComponents([Calendar.Component.month, Calendar.Component.year], from: self.calendar.currentPage)
        if let month = values.month {
            let monthName = DateFormatter().monthSymbols[month - 1]
            lblMonthYear.text = "\(monthName) \(String(describing: values.year ?? 0))"
        }

        if let year = values.year {
            lblYear.text = "\(String(describing: year) )"
        }
    }

    // MARK: - Button Actions
    @IBAction private func tapBtnPreviousArrow(_ sender: UIButton) {
        fLog()
        calendar.scrollDirection = .horizontal
        self.moveCurrentPage(moveUp: false)
    }

    @IBAction private func tapBtnBackArrow(_ sender: UIButton) {
        fLog()
        calendar.scrollDirection = .horizontal
        self.moveCurrentPage(moveUp: true)
    }

    @IBAction private func tapBtnSave(_ sender: UIButton) {
       fLog()
        self.tryingPeriodDetailModelrequest.startDateLastPeriod = self.selectedPeriodStartDate
        if self.tryingPeriodDetailModelrequest.periodCycle == PeriodCycleType.regular.rawValue {
            if let lastPeriodLongVC = Storyboard.Questions.instantiateViewController(identifier: LastPeriodLongVC.className) as? LastPeriodLongVC {
                lastPeriodLongVC.periodDetailModelRequest = self.tryingPeriodDetailModelrequest
                 self.navigationController?.pushViewController(lastPeriodLongVC, animated: true)
            }
        } else {
            if let firstDayPeriodDuration = Storyboard.Questions.instantiateViewController(identifier: FirstDayPeriodDuration.className) as? FirstDayPeriodDuration {
                firstDayPeriodDuration.periodIrregularDetailModelRequestModel = self.tryingPeriodDetailModelrequest
                 self.navigationController?.pushViewController(firstDayPeriodDuration, animated: true)
            }
        }


    }
    
    @IBAction func tapNotSureBtn(_ sender: UIButton) {
    }

    @IBAction func tapBtnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}

// MARK: -  FSCalendarDelegate,FSCalendarDataSource
extension PeriodStartDateVC: FSCalendarDelegate, FSCalendarDataSource{
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
       calendar.scrollDirection = .vertical

    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.dateFormatter.string(from: date))")

        self.selectedPeriodStartDate = Int(self.dateFormatter.string(from: date))
//
//                let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
//        print("selected dates is \(selectedDates)")

    }
}
