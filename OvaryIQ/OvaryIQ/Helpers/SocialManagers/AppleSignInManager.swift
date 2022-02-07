//
//  AppleSignInManager.swift
//  Ding
//
//  Created by Mobcoder Technologies Private Limited on 14/12/21.
//  Copyright © 2021 Naveen. All rights reserved.
//

import Foundation
import AuthenticationServices

class AppleSignInManager: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {

    private var appleSignInResult:((_ socialUserInfo: SocialUserInfo?, _ message: String?, _ success: Bool)->())?

    // MARK: - Properties ::

    internal static let shared: AppleSignInManager = {
        return AppleSignInManager()
    }()

    // MARK: - Functions ::

    @available(iOS 13.0, *)
    func addSignInButton(onView view: UIView, completionClosure: @escaping (_ socialUserInfo: SocialUserInfo?, _ message: String?, _ success: Bool) -> ()) {

        let authorizationButton = ASAuthorizationAppleIDButton(type: .continue, style: .white)
        //let authorizationButton = ASAuthorizationAppleIDButton()
        authorizationButton.addTarget(self, action: #selector(tapBtnAppleLogin(sender:)), for: .touchUpInside)
        //authorizationButton.frame = view.bounds
        view.addSubview(authorizationButton)
        view.bringSubviewToFront(authorizationButton)

        /*
        authorizationButton.makeRoundRect(radius: authorizationButton.frame.size.height/2, borderWidth: 1.0, borderColor: UIColor.lightGray)

        // Setup Layout Constraints to be in the center of the screen
        authorizationButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            authorizationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authorizationButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            authorizationButton.widthAnchor.constraint(equalToConstant: 228),
            authorizationButton.heightAnchor.constraint(equalToConstant: 49)
            ])
        */


        // Setup Layout Constraints to be in the center of the screen
        authorizationButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            authorizationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authorizationButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            authorizationButton.widthAnchor.constraint(equalToConstant: kDeviceWidth - 60),
            authorizationButton.heightAnchor.constraint(equalToConstant: 50)
            ])

        //authorizationButton.makeRoundRect(radius: 27.5, borderWidth: 0.0, borderColor: UIColor.lightGray)

        self.appleSignInResult = { socialUserInfo, message, success in
            completionClosure(socialUserInfo, message, success)
        }
    }

    @available(iOS 13.0, *)
    private func performExistingAccountSetupFlows() {
        let requests = [ASAuthorizationAppleIDProvider().createRequest(), ASAuthorizationPasswordProvider().createRequest()]

        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

    @available(iOS 13.0, *)
    func getCredentialState(userID: String) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: userID) { credentialState, _ in
            switch credentialState {
            case .authorized:
                // The Apple ID credential is valid.
                break
            case .revoked:
                // The Apple ID credential is revoked.
                break
            case .notFound:
                // No credential was found, so show the sign-in UI.
                break
            default:
                break
            }
        }
    }

    internal func login(completionClosure: @escaping (_ socialUserInfo: SocialUserInfo?, _ message: String?, _ success: Bool) -> ()) {
        print("AppleSignInManager :: Direct Login")
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()

        self.appleSignInResult = { socialUserInfo, message, success in
            completionClosure(socialUserInfo, message, success)
        }
    }

    @available(iOS 13.0, *)
    @objc private func tapBtnAppleLogin(sender: ASAuthorizationAppleIDButton) {
        print("AppleSignInManager :: tapBtnAppleLogin:")
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

    // MARK: - ASAuthorizationControllerDelegate ::

    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("AppleSignInManager :: AppleID Credential Failed With Error: \(error.localizedDescription)")
        self.appleSignInResult?(nil, "Apple Login Error", false)
    }

    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            print("AppleID Credential Authorization: userId: \(appleIDCredential.user), email: \(String(describing: appleIDCredential.email)),  name: \(String(describing: appleIDCredential.fullName))")

            let dataBlank = "".data(using: .utf8)

            // unique ID for each user, this uniqueID will always be returned
            let userIdentifier = appleIDCredential.user

            // optional, might be nil
            let userFirstName = appleIDCredential.fullName?.givenName ?? ""

            // optional, might be nil
            let userLastName = appleIDCredential.fullName?.familyName ?? ""

            let userFullName = userFirstName + userLastName

            // optional, might be nil
            let userEmail = appleIDCredential.email ?? ""

            /*
                useful for server side, the app can send identityToken and authorizationCode
                to the server for verification purpose
            */

            var identityToken: String = ""
            if let token = appleIDCredential.identityToken {
                identityToken = String(bytes: token, encoding: .utf8) ?? ""
            }

            var authorizationCode: String = ""
            if let code = appleIDCredential.authorizationCode {
                authorizationCode = String(bytes: code, encoding: .utf8) ?? ""
            }

            /*
            //KeychainManager.save(key: "Id", data: userIdentifier.data(using: .utf8) ?? dataBlank!)
            KeychainManager.save(key: "UserFirstName", data: userFirstName.data(using: .utf8) ?? dataBlank!)
            KeychainManager.save(key: "UserLastName", data: userLastName.data(using: .utf8) ?? dataBlank!)
            KeychainManager.save(key: "UserEmail", data: userEmail.data(using: .utf8) ?? dataBlank!)
             */


            let email = appleIDCredential.email ?? String(decoding: KeychainManager.load(key: "UserEmail") ?? dataBlank!, as: UTF8.self)
            let fName = appleIDCredential.fullName?.givenName ?? String(decoding: KeychainManager.load(key: "UserFirstName") ?? dataBlank!, as: UTF8.self)
            let lName = appleIDCredential.fullName?.familyName ?? String(decoding: KeychainManager.load(key: "UserLastName") ?? dataBlank!, as: UTF8.self)
            let identifier = userIdentifier

            //--- Save User Info in Keychain ---//
            if !fName.isEmpty {
                if let fNameData = fName.data(using: .utf8) {
                   _ = KeychainManager.save(key: "UserFirstName", data: fNameData)
                }
            }

            if !lName.isEmpty {
                if let lNameData = lName.data(using: .utf8) {
                   _ = KeychainManager.save(key: "UserLastName", data: lNameData)
                }
            }

            if !email.isEmpty {
                if let emailData = email.data(using: .utf8) {
                   _ = KeychainManager.save(key: "UserEmail", data: emailData)
                }
            }

            let socialUserInfo = SocialUserInfo(type: LoginType.apple, socialId: identifier, name: "\(fName + " " + lName)", email: email, profilePic: "")

            print("AppleSignInManager :: User Info = UserId: \(userIdentifier), UserName: \(userFullName), UserEmail: \(userEmail), IdentityToken: \(identityToken), AuthorizationCode: \(authorizationCode)")

            self.appleSignInResult?(socialUserInfo, "Apple Login Success", true)
        }
    }

    // MARK: - ASAuthorizationControllerPresentationContextProviding ::

    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        return sceneDelegate.window!
    }
}

