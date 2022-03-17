//
//  YearPickerVC.swift
//  OvaryIQ
//
//  Created by Mobcoder on 11/03/22.
//

import UIKit

class YearPickerVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var pickerView: UIPickerView!
    // MARK: - Properties
    internal var goBackToCalendarHomeController: ((String) -> ())?
    private var pickerData: [String] {

        let date = Date()
        let calendar = Calendar.current
        let currentYear = Calendar.current.component(.year, from: Date())
        let previousYear = currentYear - 1
        let nextYear = currentYear + 5
        dLog(message: " one year back from current year \(previousYear)")
        dLog(message: " five year ago from current year \(nextYear)")
        var years = [String]()
        for indx in (previousYear...nextYear) {
            years.append("\(indx)")
        }
        return years
    }
    private var pickerLabel = UILabel()
    private var selectedIndex: Int = 5
    // MARK: - View Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
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
      //  self.viewModel.unregisterCoreEngineEventsCallBack()
       classReleased()
    }
    // MARK: - Notifications Functions
    // MARK: - Private Functions
    // MARK: - Private Functions
    private func initialSetup() {
        pickerView.backgroundColor = .clear
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.selectRow(5, inComponent: 0, animated: true)
    }
    // MARK: - Button Actions

    @IBAction private func tapBtnCross(_ sender: Any) {
        fLog()
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction private func tapBtnTick(_ sender: Any) {
        fLog()
        self.dismiss(animated: true) {
            self.goBackToCalendarHomeController?(self.pickerData[self.selectedIndex])
        }
    }

}
// MARK: - UIPickerDelegate, UIPickerDataSource
extension YearPickerVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print("pickerDataRow...", pickerData[row])
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedIndex = row
        self.pickerView.reloadAllComponents()
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

        // picker view background clear
        if #available(iOS 14.0, *) {
            pickerView.subviews[1].backgroundColor = .clear } else {
                pickerView.subviews.forEach({
                    $0.isHidden = $0.frame.height < 1.0
                })
         }
        pickerLabel.font = UIFont(name: "SourceSansPro-SemiBold", size: 22.0)
        let rowSize = pickerView.rowSize(forComponent: component)
        pickerLabel = .init(frame: CGRect(x: 0, y: 0, width: rowSize.height + 20, height: rowSize.height))
        pickerLabel.textColor = UIColor.black
        pickerLabel.layer.masksToBounds = true
        pickerLabel.textAlignment = .center
        pickerLabel.text = pickerData[row]
        return pickerLabel
    }


    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 35
    }
}
