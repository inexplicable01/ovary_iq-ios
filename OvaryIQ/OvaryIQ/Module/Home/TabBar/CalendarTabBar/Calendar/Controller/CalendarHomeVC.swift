//
//  CalendarHomeVC.swift
//  OvaryIQ
//
//  Created by Mobcoder on 24/02/22.
//

import UIKit
struct PredictedPeriod {
    var periodName: String?
    var periodImageName: String?
    init(periodName: String, periodImageName: String) {
        self.periodName = periodName
        self.periodImageName = periodImageName
    }
}

class CalendarHomeVC: BaseViewC {
    // MARK: - IBOutlets
    @IBOutlet private  weak var calendar: FSCalendar!
    @IBOutlet private weak var lblMonthYear: UILabel!
    @IBOutlet private weak var lblYear: UILabel!
    @IBOutlet private weak var collectionViewPredictedPeriod: UICollectionView!
    @IBOutlet private weak var collectionViewMedication: UICollectionView!

    // MARK: - Properties
    private var selectedDates: String?
    private var currentPage: Date?
    private var showArr = [[SubCategoryList]]()
    private var predictedArray = [PredictedPeriod(periodName: LogPeriodCategoryType.predictedPeriod.localizedString, periodImageName: LogPeriodCategoryType.predictedPeriod.image), PredictedPeriod(periodName: LogPeriodCategoryType.fertileWindow.localizedString, periodImageName: LogPeriodCategoryType.fertileWindow.image),PredictedPeriod(periodName: LogPeriodCategoryType.ovulation.localizedString, periodImageName: LogPeriodCategoryType.ovulation.image),PredictedPeriod(periodName: LogPeriodCategoryType.predictedPregnancyTest.localizedString, periodImageName: LogPeriodCategoryType.ovulation.image)]
    private lazy var today: Date = {
        return Date()
    }()
    private lazy var dateFormatter: DateFormatter = {
           let formatter = DateFormatter()
        formatter.dateFormat = DateFormat.yearMonthDate.rawValue
           return formatter
    }()
    private var viewModel = CalendarHomeViewModel()
    private var saveUserLogPeriodDataRequestModel = SaveUserLogPeriodDataRequestModel()
    private var getDataLogPeriodDataModel: GetDataForLogPeriodDataModel?
    private var getUserMedicalOptionsDataModel: GetUsersMedicalOptionsDataModel?
    private var getUserLogPeriodDataModel: GetUserLogPeriodDataModel?
    // MARK: - View Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.registerCoreEngineEventsCallBack()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.registerCoreEngineEventsCallBack()
        self.initialSetup()
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
    // MARK: - Private and internal Functions
    private func initialSetup() {
        calendar.register(Cell.self, forCellReuseIdentifier: "Cell")
        self.calendar.appearance.titleFont = UIFont(name: "SourceSansPro-Bold", size: 16)
        self.calendarSetUp()
        self.viewModel.delegate = self
        self.viewModel.callApiToGetUsersMedicalOptionsData()
        self.viewModel.callApiToGetDataForLogPeriod()
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
        calendar.dataSource = self
    }
    private func moveCurrentPage(moveUp: Bool) {
        let calendar = Calendar.current
        let dateComponents = DateComponents()
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
    private func setSelectedYearInCalendar(selectedYear: String) {
        let year = Int(selectedYear)
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self.calendar.currentPage)
       // dateComponents.setValue(month, for: .month)
        dateComponents.setValue(year, for: .year)
        let date = Calendar.current.date(from: dateComponents)
        self.calendar.setCurrentPage(date!, animated: true)
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

    // MARK: - Button Actions
    @IBAction private func tapBtnProfile(_ sender: UIButton) {
        fLog()
        if let profileVC = Storyboard.Settings.instantiateViewController(identifier: SideOptionsVC.className) as? SideOptionsVC {
             self.navigationController?.pushViewController(profileVC, animated: true)
        }
    }
    @IBAction private func tapBtnOpenYearPicker(_ sender: Any) {
        fLog()
        if let yearPickerVC = Storyboard.Home.instantiateViewController(identifier: YearPickerVC.className) as? YearPickerVC {
            yearPickerVC.modalPresentationStyle = .overFullScreen
            yearPickerVC.goBackToCalendarHomeController = { [weak self]  selectedYear in
                self?.lblYear.text = "\(String(describing: selectedYear) )"
                dLog(message: "Slected year From YearPicker..", filename: selectedYear)
                self?.setSelectedYearInCalendar(selectedYear: selectedYear)
            }
            self.navigationController?.present(yearPickerVC, animated: true, completion: nil)
        }
    }

    @IBAction private func tapBtnClalendarBtn(_ sender: Any) {
        fLog()
        self.moveCurrentPage(moveUp: true)
    }
}
//MARK: -  FSCalendarDelegate,FSCalendarDataSource
  extension CalendarHomeVC: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
       calendar.scrollDirection = .vertical
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        dLog(message: "did select date \(self.dateFormatter.string(from: date))")
        let dateSelected = self.dateFormatter.string(from: date)
        self.selectedDates = dateSelected
        let myViews = calendar.cell(for: date, at: FSCalendarMonthPosition.current)?.subviews.compactMap{$0 as? SavedUserMedicalData}
        let newDateStrView = myViews?.filter({($0.dateStr ?? "") == dateSelected})
            dLog(message: "myViews..\(myViews)")
            dLog(message: "newDateStrView...\(newDateStrView)")
        if !(newDateStrView?.isEmpty ?? false) {
            if let cii = calendar.cell(for: date, at: FSCalendarMonthPosition.current) as?  Cell {
                cii.superview?.bringSubviewToFront(cii)
            }
                UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                    newDateStrView?.first?.isZoom = !(newDateStrView?.first?.isZoom ?? false)

                    if newDateStrView?.first?.isZoom ?? false {
                        newDateStrView?.first?.transform = CGAffineTransform.identity.scaledBy(x: 1.2, y: 1.2) // Scale your image
                    } else {
                        newDateStrView?.first?.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1) // Scale your image
                    }

                 })
        }
        if  let abc = calendar.cell(for: date, at: FSCalendarMonthPosition.current)?.superview?.subviews {
           for subView in abc {
                let myViews = subView.subviews.compactMap{$0 as? SavedUserMedicalData}
                let newDateStrView = myViews.filter({($0.dateStr ?? "") != dateSelected})

             for item in newDateStrView {
                    item.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0) // Scale your image
                }
            }
        }


    }
      func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
          if let cell = calendar.dequeueReusableCell(withIdentifier: Cell.className, for: date, at: position) as? Cell {
              let newDate = self.dateFormatter.string(from: date)
              // here added xib on selectedSavedData
              AppConfig.defautMainQ.async {
                 // getUserMedicalOptionsDataModel
                  if let medicalOptions = self.getUserMedicalOptionsDataModel?.medicalOptionsList {
                      self.showArr.removeAll()
                    for (offset, value) in medicalOptions.enumerated() {
                          let filterdata = medicalOptions[offset].subCategoryList.filter({$0.date == newDate})
                        if !(filterdata.isEmpty) {
                            self.showArr.append(filterdata)
                        }
                        dLog(message:"Filter Data...", filename: "\(filterdata)")

                      }
                      let newShowArr = self.showArr.flatMap({$0})

                      if !(newShowArr.isEmpty) {
                          let myView = SavedUserMedicalData()
                          myView.frame = cell.contentView.frame
                          myView.clipsToBounds = false
                          cell.addSubview(myView)
                         // cell.bringSubviewToFront(myView)
                          myView.delegate = self
                          if let optionsArr = self.getUserMedicalOptionsDataModel?.medicalOptionsList {
                              myView.medicalOptionsListDataModel = optionsArr
                          }
                          myView.medicalOptionSubCategoryListArr = newShowArr

                          myView.dateStr = newDate
                        } else {
                              let myitem = cell.subviews.compactMap{$0 as? SavedUserMedicalData}
                              for item in myitem {
                                  item.removeFromSuperview()
                              }
                        }
                      }
                  }
              return cell
          }
          return FSCalendarCell()
      }
      func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
          let dateString = self.dateFormatter.string(from: date)
         // let splitArr = split(self.getUserLogPeriodDataModel?.predictions?.fertileWindow?){$0 == ","}
//          if self.getUserLogPeriodDataModel?.predictions?.fertileWindow?.contains(dateString){
//              return  UIImageType.fertileWindow.image
//          }
          switch dateString {
          case self.getUserLogPeriodDataModel?.predictions?.predictedPeriod:
                return  UIImageType.predictedPeriod.image
          case self.getUserLogPeriodDataModel?.predictions?.ovulation:
                return  UIImageType.ovulation.image
//          case self.getUserLogPeriodDataModel?.predictions?.fertileWindow?.contains(dateString):
                    //return  UIImageType.fertileWindow.image
          default:
                return nil

          }
        //  return self.datesWithEvent.contains(dateString) ? UIImage(named: "FertileWindow") : nil



      }
}
// MARK: -  UICollectionViewDelegate, UICollectionViewDataSource
extension CalendarHomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let logPeriodsOptionsBottomSheetController = Storyboard.Home.instantiateViewController(identifier: LogPeriodsOptionsBottomSheetController.className) as? LogPeriodsOptionsBottomSheetController {
            logPeriodsOptionsBottomSheetController.delegate = self
            logPeriodsOptionsBottomSheetController.selectedDate = self.selectedDates ?? ""
            logPeriodsOptionsBottomSheetController.medicalOptionsDataModel = self.getDataLogPeriodDataModel?.medicalOptionsList[indexPath.row]
            logPeriodsOptionsBottomSheetController.modalPresentationStyle = .overFullScreen
            self.navigationController?.present(logPeriodsOptionsBottomSheetController, animated: true, completion: nil)
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }

    // MARK: - UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewMedication {
            return self.getDataLogPeriodDataModel?.medicalOptionsList.count ?? 0
        } else {
            return self.predictedArray.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       if collectionView == collectionViewMedication {
           if let cell: MedicationsOptionsCVC = collectionView.dequeueReusableCell(withReuseIdentifier: MedicationsOptionsCVC.className, for: indexPath) as? MedicationsOptionsCVC {
               cell.configCell(model: self.getDataLogPeriodDataModel?.medicalOptionsList[indexPath.row])
               return cell
           }
        } else {
            if let cell: PredictedPeriodOtionsCVC = collectionView.dequeueReusableCell(withReuseIdentifier: PredictedPeriodOtionsCVC.className, for: indexPath) as? PredictedPeriodOtionsCVC {
                cell.configCell(model: self.predictedArray[indexPath.row])
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
             return CGSize(width: collectionView.frame.size.width / 3.5, height: 30)
         }
    }
}
// MARK: - Protocol and delegate method

extension CalendarHomeVC: CalendarHomeViewModelDelegate {
    func getUsersMedicalOptionsDataModel(medicalOptionsDataModel: GetUsersMedicalOptionsDataModel) {
        var medicalOptionModel = medicalOptionsDataModel
        for (indx, value) in medicalOptionModel.medicalOptionsList.enumerated() {
            medicalOptionModel.medicalOptionsList[indx].categoryImage = Helper.getMedicationIcon(name: value.name ?? "")
            for (inx, subValue) in value.subCategoryList.enumerated() {
                medicalOptionModel.medicalOptionsList[indx].subCategoryList[inx].subCategoryImage = Helper.getIcon(name: subValue.name ?? "")
                medicalOptionModel.medicalOptionsList[indx].subCategoryList[inx].categoryImage = Helper.getMedicationIcon(name: value.name ?? "")
            }
        }
        dLog(message: "Saved User Medical Options:- \(medicalOptionModel)")
        self.getUserMedicalOptionsDataModel = medicalOptionModel
        self.calendar.reloadData()
        //self.collectionViewMedication.reloadData()
    }

    func getUserlogPeriodResponse(dataModel: GetUserLogPeriodDataModel) {
     dLog(message: "GetUserLogPeriodDataResponse...\(dataModel)")
        if dataModel.predictions?.isExist == false {
            AlertControllerManager.showOkAlert(title: "", message: ErrorMessages.canNotPredictPeriod.localizedString)
//            AlertControllerManager.showToast(message: ErrorMessages.canNotPredictPeriod.localizedString, type: .error)
        } else {
            self.getUserLogPeriodDataModel = dataModel
            self.calendar.reloadData()

        }

        //self.saveUserLogPeriodDataRequestModel.id = dataModel.logData?.first?.id
    }

    func getDataForlogPeriodResponse(dataModel: GetDataForLogPeriodDataModel) {
        dLog(message: "Get data for log period:- \(dataModel)")
        self.getDataLogPeriodDataModel = dataModel
        self.collectionViewMedication.reloadData()
    }
}
extension CalendarHomeVC: LogPeriodsOptionsBottomSheetControllerDelegate,LogPeriodDoneBottomSheetVCDelegate{

    func saveLoggedPeriodSuccessResponse(eventID: RestEvents) {
        if eventID == .saveLogPeriod {
            self.viewModel.callApiToGetUserLogPeriodData()
        } else {
            self.viewModel.callApiToGetUsersMedicalOptionsData()
        }

    }
    func goBackToCalendarController(saveMedicationsSelectedDataModel: SaveMedicationRequestModel) {
        if let logPeriodDoneBottomSheetVC = Storyboard.Home.instantiateViewController(identifier: LogPeriodDoneBottomSheetVC.className) as? LogPeriodDoneBottomSheetVC {
            logPeriodDoneBottomSheetVC.modalPresentationStyle = .overFullScreen
            logPeriodDoneBottomSheetVC.delegate = self
            logPeriodDoneBottomSheetVC.saveUserLogPeriodRequestModel = self.saveUserLogPeriodDataRequestModel
            logPeriodDoneBottomSheetVC.saveMedicationRequestModel = saveMedicationsSelectedDataModel
            self.navigationController?.present(logPeriodDoneBottomSheetVC, animated: true, completion: nil)
        }
    }

}
extension CalendarHomeVC: SavedUserMedicalDataDelegate {
    func didSelectMethodCalled(sender: UIView, subCategoaryModel: [SubCategoryList]) {
        dLog(message: "Filter Sub Category Model....\(subCategoaryModel)")
        if let popVC = Storyboard.Home.instantiateViewController(identifier: PopOverViewControlller.className) as? PopOverViewControlller {
            popVC.headerArray = subCategoaryModel
            let height: CGFloat = CGFloat(35 * popVC.headerArray.count)
            let width: CGFloat = sender.frame.width + 100
            popVC.modalPresentationStyle = .popover
            popVC.preferredContentSize = CGSize(width: width, height: height)
            // vc.delegate = self
            let popOver = popVC.popoverPresentationController
             popOver?.delegate = self
            popOver?.permittedArrowDirections = [.up]
            popOver?.sourceView = sender
            popoverPresentationController?.sourceRect = sender.bounds
            self.present(popVC, animated: true, completion: nil)

        }
    }
}

extension CalendarHomeVC: UIPopoverPresentationControllerDelegate {
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }

    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}
