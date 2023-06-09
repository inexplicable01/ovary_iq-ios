//
//  LogPeriodDoneBottomSheetVC.swift
//  OvaryIQ
//
//  Created by Mobcoder on 04/03/22.
//

import UIKit
protocol LogPeriodDoneBottomSheetVCDelegate {
    func saveLoggedPeriodSuccessResponse(eventID: RestEvents)
}

class LogPeriodDoneBottomSheetVC: BaseViewC {
    // MARK: - IBOutlets
    // MARK: - Properties
    internal var saveMedicationRequestModel: SaveMedicationRequestModel?
    internal var saveUserLogPeriodRequestModel: SaveUserLogPeriodDataRequestModel?
    private var viewModel = LogPeriodSaveDateBottomSheetViewModel()
    internal var delegate: LogPeriodDoneBottomSheetVCDelegate?
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
        self.viewModel.unregisterCoreEngineEventsCallBack()
       classReleased()
    }

    // MARK: - Notifications Functions
    // MARK: - Private and internal Functions
    private func initialSetup() {
        self.viewModel.saveMedicationRequestModel = saveMedicationRequestModel
        self.viewModel.saveUserSelectedLogPeriodRequestModel = self.saveUserLogPeriodRequestModel
        self.viewModel.delegate = self
    }
    // MARK: - Button Actions
    @IBAction private func tapBtnCross(_ sender: Any) {
        fLog()
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction private func tapBtnTick(_ sender: Any) {
        fLog()
        self.dismiss(animated: true) {
            self.viewModel.callApiToSavePeriodAndMedications(type: self.saveMedicationRequestModel?.periodType ?? "")
        }
    }
}
// MARK: - Protocol and delegate Functions
extension LogPeriodDoneBottomSheetVC: LogPeriodSaveDateBottomSheetViewModelDelegate {
    func sucessSaveLogPeriosApiResponse(eventType: RestEvents) {
        dLog(message: "save Logged period api get called")
        self.delegate?.saveLoggedPeriodSuccessResponse(eventID: eventType)

    }
}
