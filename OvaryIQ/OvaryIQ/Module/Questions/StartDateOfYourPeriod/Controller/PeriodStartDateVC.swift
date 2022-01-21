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

    // MARK: - Properties
    private var currentPage: Date?
    private lazy var today: Date = {
        return Date()
    }()

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
        self.calendarSetUp()
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
    }


    internal func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("change calendar ")
        let currentPageDate = calendar.currentPage
        let month = Calendar.current.component(.month, from: currentPageDate)
        let year = Calendar.current.component(.year, from: currentPageDate)
        let monthName  = DateFormatter().monthSymbols[month - 1]
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
        if let month = values.month{
            let monthName = DateFormatter().monthSymbols[month - 1]
            lblMonthYear.text = "\(monthName) \(String(describing: values.year ?? 0))"
        }
        if let year = values.year{
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
    }
}

// MARK: -  FSCalendarDelegate,FSCalendarDataSource
extension PeriodStartDateVC: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
       calendar.scrollDirection = .vertical

    }
}
