//
//  Helper.swift
//  OvaryIQ
//
//  Created by Mobcoder on 19/01/22.
//

import Foundation
import UIKit
import Lottie
class Helper {
    //MARK: -  Show Home Screen as root controller
    class func showHomeScreen() {
       // let vc = Storyboard.Home.instantiateViewController(withIdentifier: HomeVC.className) as! HomeVC
        let vc = Storyboard.Home.instantiateViewController(withIdentifier: TabBarController.className) as! TabBarController
        let nav = UINavigationController.init(rootViewController: vc)
        nav.isNavigationBarHidden = true
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = nav
            window.makeKeyAndVisible()
        }
    }
    //MARK: -  Show AnswerFewQuestions Screen as root controller
    class func showAnswerFewQuestionsScreen() {
        let vc = Storyboard.Questions.instantiateViewController(withIdentifier: AnswersFewQuestionsVC.className) as! AnswersFewQuestionsVC
        let nav = UINavigationController.init(rootViewController: vc)
        nav.isNavigationBarHidden = true
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = nav
            window.makeKeyAndVisible()
        }
    }

    //MARK: -  Show AnswerFewQuestions Screen as root controller
    class func showAuthOptionVCScreen() {
        let vc = Storyboard.Auth.instantiateViewController(withIdentifier: AuthOptionVC.className) as! AuthOptionVC
        let nav = UINavigationController.init(rootViewController: vc)
        nav.isNavigationBarHidden = true
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = nav
            window.makeKeyAndVisible()
        }
    }

    //Show egg loader
    class func showLoader() {
        let controller = getTopMostViewController()
        hideLoader()
        var progressView: AnimationView?
        progressView = AnimationView(name: "Loader")
        progressView?.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        progressView?.center = controller.view.center
        progressView?.contentMode = .scaleAspectFill
        progressView?.animationSpeed = 1
        progressView?.loopMode = .loop
        controller.view.addSubview(progressView!)
        progressView?.play()
    }
   class func hideLoader() {
       let controller = getTopMostViewController()
       for controller in controller.view.subviews where controller is AnimationView {
           controller.removeFromSuperview()
        }
    }

    // MARK: - Set Up Application UI Appearance

   class func getTopMostViewController() -> UIViewController {

        if var topController = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return UIViewController()
    }
    // MARK: - GetIcon
        class func getMedicationIcon(name: String) -> String {
            switch name {
            case  UserMedicalOptionsType.logPeriod.rawValue:
                return UserMedicalOptionsType.logPeriod.image

            case  UserMedicalOptionsType.medication.rawValue:
                return UserMedicalOptionsType.medication.image

            case  UserMedicalOptionsType.procedure.rawValue:
                return UserMedicalOptionsType.procedure.image

            case  UserMedicalOptionsType.activity.rawValue:
                return UserMedicalOptionsType.activity.image

            case  UserMedicalOptionsType.symptoms.rawValue:
                return UserMedicalOptionsType.symptoms.image

            case  UserMedicalOptionsType.pregnancyTest.rawValue:
                  return UserMedicalOptionsType.pregnancyTest.image
            default:
                    return UserMedicalOptionsType.logPeriod.image
            }

        }

    // MARK: - GetIcon
        class func getIcon(name: String) -> String {
            switch name {

               // Log Period Categpry Images
            case  LogPeriodCategoryType.logPeriod.rawValue:
                return LogPeriodCategoryType.logPeriod.image

            case  LogPeriodCategoryType.medication.rawValue:
                return LogPeriodCategoryType.medication.image

            case  LogPeriodCategoryType.procedure.rawValue:
                return LogPeriodCategoryType.procedure.image

            case  LogPeriodCategoryType.activity.rawValue:
                return LogPeriodCategoryType.activity.image

            case  LogPeriodCategoryType.symptoms.rawValue:
                return LogPeriodCategoryType.symptoms.image

            case  LogPeriodCategoryType.pregnancyTest.rawValue:
                  return LogPeriodCategoryType.pregnancyTest.image

                    // FOR LOGPERIOD
            case LogPeriodCategoryType.regularFlow.rawValue:
                  return LogPeriodCategoryType.regularFlow.image
            case LogPeriodCategoryType.heavyBledding.rawValue:
                  return LogPeriodCategoryType.heavyBledding.image

                    // FOR MEDICATIONS
            case LogPeriodCategoryType.stimulationInjection.rawValue:
                 return LogPeriodCategoryType.stimulationInjection.image
            case LogPeriodCategoryType.tigger.rawValue:
                 return LogPeriodCategoryType.tigger.image
            case LogPeriodCategoryType.birthControl.rawValue:
                 return LogPeriodCategoryType.birthControl.image
            case LogPeriodCategoryType.clomid.rawValue:
                return LogPeriodCategoryType.clomid.image
            case LogPeriodCategoryType.letrozole.rawValue:
                return LogPeriodCategoryType.letrozole.image
            case LogPeriodCategoryType.tamoxifane.rawValue:
                return LogPeriodCategoryType.tamoxifane.image

                   // FOR PROCEDURE
            case LogPeriodCategoryType.iUI.rawValue:
                return LogPeriodCategoryType.iUI.image
            case LogPeriodCategoryType.d3EmbryoTransfer.rawValue:
                return LogPeriodCategoryType.d3EmbryoTransfer.image
            case LogPeriodCategoryType.d5EmbryoTransfer.rawValue:
                return LogPeriodCategoryType.d5EmbryoTransfer.image

                    // FOR ACTIVITY
            case LogPeriodCategoryType.sex.rawValue:
                return LogPeriodCategoryType.sex.image

                   // FOR SYMPTOMS
            case LogPeriodCategoryType.bloating.rawValue:
                return LogPeriodCategoryType.bloating.image
            case LogPeriodCategoryType.pain.rawValue:
                return LogPeriodCategoryType.pain.image
            case LogPeriodCategoryType.haedaches.rawValue:
                return LogPeriodCategoryType.haedaches.image
            case LogPeriodCategoryType.diarrhea.rawValue:
                return LogPeriodCategoryType.diarrhea.image
            case LogPeriodCategoryType.weightGain.rawValue:
                return LogPeriodCategoryType.weightGain.image
            case LogPeriodCategoryType.fatigue.rawValue:
                return LogPeriodCategoryType.fatigue.image
            case LogPeriodCategoryType.emotional.rawValue:
                return LogPeriodCategoryType.emotional.image
            case LogPeriodCategoryType.increasedhunger.rawValue:
                return LogPeriodCategoryType.increasedhunger.image

                    // FOR PREGNANCY TEST
            case LogPeriodCategoryType.reminderToTakeThePregnancyTest.rawValue:
                return LogPeriodCategoryType.reminderToTakeThePregnancyTest.image
            case LogPeriodCategoryType.positiveTestResult.rawValue:
                return LogPeriodCategoryType.positiveTestResult.image
            case LogPeriodCategoryType.negativeTestResult.rawValue:
                return LogPeriodCategoryType.negativeTestResult.image

            default:
                    return LogPeriodCategoryType.logPeriod.image
            }

        }
    // MARK: - convert date format
    class func convertDateFormat(InputDateFormat: String, OutputDateFormate: String, date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = InputDateFormat
        let date = dateFormatter.date(from: date ?? "")
        dateFormatter.dateFormat = OutputDateFormate
        let resultString = dateFormatter.string(from: date ?? Date())
        return resultString
    }
//    class func getDayFromDate(selecteddate: String) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = DateFormat.yearMonthDate.rawValue
//        let date = dateFormatter.date(from: selecteddate ?? "")
//        return "\(date?.get(.day))"
//    }


}
