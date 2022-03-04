//
//  LogPeriodDoneBottomSheetVC.swift
//  OvaryIQ
//
//  Created by Mobcoder on 04/03/22.
//

import UIKit

class LogPeriodDoneBottomSheetVC: BaseViewC {
    // MARK: - IBOutlets
    // MARK: - Properties
    internal var saveMedicationRequestModel : SaveMedicationRequestModel?
    private var viewModel = LogPeriodSaveDateBottomSheetViewModel()
    // MARK: - View Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()

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
        self.viewModel.saveMedicationRequestModel = saveMedicationRequestModel
    }
    // MARK: - Button Actions

    @IBAction private func tapBtnCross(_ sender: Any) {
        fLog()
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction private func tapBtnTick(_ sender: Any) {
        fLog()
        self.dismiss(animated: true) {
            self.viewModel.callApiToSavePeriodAndMedications()
        }
    }

}
