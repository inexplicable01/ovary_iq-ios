//  AuthSignUpVC.swift
//  OvaryIQ
//
//  Created by Mobcoder on 12/01/22.
//

import UIKit
import SKCountryPicker

class AuthSignUpVC: BaseViewC {

    // MARK: - IBOutlets
    @IBOutlet private weak var btnCreateAccount: UIButton!
    @IBOutlet private weak var btnEyeShowHidePassword: UIButton!
    @IBOutlet private weak var txtFieldName: UITextField!
    @IBOutlet private weak var txtfieldPhoneNumber: UITextField!
    @IBOutlet private weak var txtFieldEmail: UITextField!
    @IBOutlet private weak var txtFieldPassword: UITextField!
    @IBOutlet private weak var lblCountryCode: UILabel!

    // MARK: - Properties
    private var viewModel = AuthSignUpViewModel()
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

    // MARK: - Notifications Functions

    // MARK: - Private Functions

    private func initialSetup() {
        self.btnCreateAccount.applyGradient(colors: [UIColor(red: 255.0 / 255.0, green: 109.0 / 255.0, blue: 147.0 / 255.0, alpha: 1.0).cgColor, UIColor(red: 253.0 / 255.0, green: 147.0 / 255.0, blue: 167.0 / 255.0, alpha: 1.0).cgColor])
        self.viewModel.delegate = self
    }

    private func showCountyPicker() -> Void {
        _ = CountryPickerWithSectionViewController.presentController(on: self) { [weak self] (country: Country) in
             guard let self = self else { return }
             self.lblCountryCode.text = country.dialingCode
            self.viewModel.authSignupRequestModel.countryCode = country.dialingCode ?? "+91"
         }
     }

    // MARK: - Button Actions

    @IBAction private func tapBtnCountryPicker(_ sender: UIButton){
        fLog()
        self.showCountyPicker()

    }
    @IBAction private func tapBtnLogin(_ sender: Any) {
        fLog()
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction private func tapBtnEye(_ sender: UIButton) {
        fLog()
        txtFieldPassword.isSecureTextEntry = sender.isSelected
        sender.isSelected = !sender.isSelected
    }

    @IBAction private func tapBtnBack(_ sender: UIButton) {
        fLog()
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction private func tapBtnCreateAccount(_ sender: UIButton) {
        fLog()

        let name = self.viewModel.authSignupRequestModel.name
        let phoneNumber = self.viewModel.authSignupRequestModel.mobile
        let email = self.viewModel.authSignupRequestModel.email
        let password = self.viewModel.authSignupRequestModel.password

        if name.isEmpty {
            AlertControllerManager.showToast(message: ErrorMessages.emptyName.localizedString, type: .error)
        } else if phoneNumber.isEmpty {
            AlertControllerManager.showToast(message: ErrorMessages.emptyPhoneNumber.localizedString, type: .error)
        } else if email.isEmpty {
            AlertControllerManager.showToast(message: ErrorMessages.emptyEmail.localizedString, type: .error)
        } else if !(email.isValidemail()) {
            AlertControllerManager.showToast(message: ErrorMessages.invalidEmailId.localizedString, type: .error)
        } else if password.isEmpty {
            AlertControllerManager.showToast(message: ErrorMessages.emptyPassword.localizedString, type: .error)
        } else if !(password.isValidPassword()) {
            AlertControllerManager.showToast(message: ErrorMessages.invalidPassword.localizedString, type: .error)
        } else {
            self.viewModel.callApiToSignUp()
       }
    }
}
// MARK: - UITextFieldDelegate

extension AuthSignUpVC: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {

    }

    func textFieldDidEndEditing(_ textField: UITextField) {

    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let finalText = currentText.replacingCharacters(in: stringRange, with: string)

        dLog(message: "Final Text :: \(finalText)")
        if textField == self.txtFieldName {
            self.viewModel.authSignupRequestModel.name = finalText.removeWhiteSpacesAndNewLines()
            do {

//                let regularExpression = "^[a-zA-Z]{2,5}$"
//                let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", regularExpression)
//                return passwordValidation.evaluate(with: finalText)

//               // ".*[^A-Za-z ].*"
                let regex = try NSRegularExpression(pattern: ".*[^A-Za-z ].*", options: [])
                    if regex.firstMatch(in: string, options: [], range: NSMakeRange(0, string.count)) != nil {
                            return false
                    }
                }
                catch {
                    print("ERROR")
                }

               return true

          } else if textField == self.txtfieldPhoneNumber {
            self.viewModel.authSignupRequestModel.mobile = finalText.removeWhiteSpacesAndNewLines()
//

        } else if textField == self.txtFieldEmail {
            self.viewModel.authSignupRequestModel.email = finalText.removeWhiteSpacesAndNewLines()
        } else if textField == self.txtFieldPassword {
            self.viewModel.authSignupRequestModel.password = finalText.removeWhiteSpacesAndNewLines()
        }

        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        fLog()
        textField.resignFirstResponder()
        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
}

// MARK: - Protocol and delegate method
extension AuthSignUpVC: AuthSignUpViewModelDelegate {

    // here after sucess response of signup we jump to answer few Questions screen
    func sucessRegisterApiResponse() {
        if UserDefaults.isGoalSaved == false {
                //here show answer question screen as rootviewController
                Helper.showAnswerFewQuestionsScreen()
        }else{
                //here show home screen as rootviewController
                Helper.showHomeScreen()
        }

    }
}
