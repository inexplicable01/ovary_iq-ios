//
//  Enums.swift
//  OvaryIQ
//
//  Created by Mobcoder on 01/02/22.
//

import Foundation
enum LoginType: String {
    case google = "google"
    case facebook = "facebook"
    case apple = "apple"

}

enum PeriodCycleType: String {
   case regular = "regular"
   case irregular = "irregular"
   case notKnow = "not_know"
}

// MARK: - dateformat
enum DateFormat: String {
    case dayMonthYear = "dd/MM/yyyy"
    case yearMonthDate = "yyyy-MM-dd"
    case day = "dd"
    case monthDate = "MMM dd"
    case month = "MM"
    case monthDateYear = "EEEE, MMM dd yyyy"
}
enum GoalType: String {
   case getPregnant = "Get Pregnant"
   case periodTracking = "Period Tracking"
}

// MARK: - Log Period SubTypesImages
enum LogPeriodCategoryType: String {
    // LOGPERIOD CATEGORY
    case logPeriod = "Log Period"
    case medication = "Medication"
    case procedure = "Procedure"
    case activity = "Activity"
    case symptoms = "Symptoms"
    case pregnancyTest = "Pregnancy Test"
    // FOR PREDICTED PERIOD
    case predictedPeriod = "Predicted Period"
    case fertileWindow = "Fertile Window"
    case ovulation = "Ovulation"
    case predictedPregnancyTest = "PregnancyTest"

    // subCategory

    // FOR LOGPERIOD
    case regularFlow = "Regular Flow"
    case heavyBledding = "Heavy Bledding"

    // FOR MEDICATIONS
    case stimulationInjection = "Stimulation Injection"
    case tigger = "Tigger"
    case birthControl = "Birth Control"
    case clomid = "Clomid"
    case letrozole = "Letrozole"
    case tamoxifane = "Tamoxifane"

    // FOR PROCEDURE
    case iUI = "IUI"
    case d3EmbryoTransfer = "D3 Embryo Transfer"
    case d5EmbryoTransfer = "D5 Embryo Transfer"

    // FOR ACTIVITY
    case sex = "Sex"

    // FOR SYMPTOMS
    case bloating = "Bloating"
    case pain = "Pain"
    case haedaches = "Haedaches"
    case diarrhea = "Diarrhea"
    case weightGain = "Weight Gain"
    case fatigue = "Fatigue"
    case emotional = "Emotional"
    case increasedhunger = "Increased hunger"

    // FOR PREGNANCY TEST
    case reminderToTakeThePregnancyTest = "Reminder to take the Pregnancy Test"
    case positiveTestResult = "Positive Test result"
    case negativeTestResult = "Negative Test result"

    var localizedString: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
    var image: String {
        switch self {
        case .logPeriod: return LogPeriodCategoryTypeImage.logPeriod.imageName
        case .medication: return LogPeriodCategoryTypeImage.medication.imageName
        case .procedure: return LogPeriodCategoryTypeImage.procedure.imageName
        case .activity: return LogPeriodCategoryTypeImage.activity.imageName
        case .symptoms: return LogPeriodCategoryTypeImage.symptoms.imageName
        case .pregnancyTest: return LogPeriodCategoryTypeImage.pregnancyTest.imageName

                // FOR PREDICTED PERIOD
        case .predictedPeriod: return LogPeriodCategoryTypeImage.predictedPeriod.imageName
        case .fertileWindow: return LogPeriodCategoryTypeImage.fertileWindow.imageName
        case .ovulation:return LogPeriodCategoryTypeImage.ovulation.imageName
        case .predictedPregnancyTest: return LogPeriodCategoryTypeImage.predictedPregnancyTest.imageName

                // FOR LOGPERIOD
        case .regularFlow: return LogPeriodCategoryTypeImage.regularFlow.imageName
        case .heavyBledding: return LogPeriodCategoryTypeImage.heavyBledding.imageName

                // FOR MEDICATIONS
        case .stimulationInjection: return LogPeriodCategoryTypeImage.medication.imageName
        case .tigger: return LogPeriodCategoryTypeImage.medication.imageName
        case .birthControl: return LogPeriodCategoryTypeImage.birthControl.imageName
        case .clomid: return LogPeriodCategoryTypeImage.birthControl.imageName
        case .letrozole: return LogPeriodCategoryTypeImage.birthControl.imageName
        case .tamoxifane: return LogPeriodCategoryTypeImage.birthControl.imageName

                // FOR PROCEDURE
        case .iUI: return LogPeriodCategoryTypeImage.iUI.imageName
        case .d3EmbryoTransfer: return LogPeriodCategoryTypeImage.d3EmbryoTransfer.imageName
        case .d5EmbryoTransfer: return LogPeriodCategoryTypeImage.d5EmbryoTransfer.imageName

                // FOR ACTIVITY
        case .sex: return LogPeriodCategoryTypeImage.sex.imageName

                // FOR SYMPTOMS
        case .bloating: return LogPeriodCategoryTypeImage.sex.imageName
        case .pain: return LogPeriodCategoryTypeImage.pain.imageName
        case .haedaches: return LogPeriodCategoryTypeImage.haedaches.imageName
        case .diarrhea: return LogPeriodCategoryTypeImage.diarrhea.imageName
        case .weightGain: return LogPeriodCategoryTypeImage.weightGain.imageName
        case .fatigue: return LogPeriodCategoryTypeImage.fatigue.imageName
        case .emotional: return LogPeriodCategoryTypeImage.emotional.imageName
        case .increasedhunger: return LogPeriodCategoryTypeImage.increasedhunger.imageName

                // FOR PREGNANCY TEST
        case .reminderToTakeThePregnancyTest: return LogPeriodCategoryTypeImage.reminderToTakeThePregnancyTest.imageName
        case .positiveTestResult: return LogPeriodCategoryTypeImage.positiveTestResult.imageName
        case .negativeTestResult: return LogPeriodCategoryTypeImage.negativeTestResult.imageName

        }
       
    }
}
// MARK: - image string
enum LogPeriodCategoryTypeImage: String {
    // Category
    case logPeriod = "LogPeriod"
    case medication = "StimulationInjection"
    case procedure = "Procedure"
    case activity = "Activity"
    case symptoms = "SymptomsBlue"
    case pregnancyTest = "PregancyTest"

    // FOR PREDICTED PERIOD
    case predictedPeriod = "PredictedPeriod"
    case fertileWindow = "FertileWindow"
    case ovulation = "Ovulation"
    case predictedPregnancyTest = "PregnancyTest"

    // SubCategoryType::

        //FOR LOGPERIOD
    case regularFlow = "regularFlow"
    case heavyBledding = "HeavyBleeding"

          // FOR MEDICATIONS
    // case stimulationInjection = "StimulationInjection"
    //  case Tigger = "StimulationInjection"
    case birthControl = "BirthControl"
    // case Clomid = "BirthControl"
    //case letrozole = "letrozole"
    //case tamoxifane = "tamoxifane"

         // FOR PROCEDURE
    case iUI = "IUI"
    case d3EmbryoTransfer = "D3EmbryoTransfer"
    case d5EmbryoTransfer = "D5EmbryoTransfer"

        // FOR ACTIVITY
    case sex = "sex"

       // FOR SYMPTOMS
    case bloating = "Bloating"
    case pain = "Pain"
    case haedaches = "Headaches"
    case diarrhea = "Diarrhea"
    case weightGain = "WeightGain"
    case fatigue = "Fatigue"
    case emotional = "Emotional"
    case increasedhunger = "Increasedhunger"

       // FOR PREGNANCY TEST
    case reminderToTakeThePregnancyTest = "reminderToTakeThePregnancyTest"
    case positiveTestResult = "PositiveTestresult"
    case negativeTestResult = "NegativeTestresult"

    var imageName: String {
        return self.rawValue
    }

}

// MARK: - For user medications image string
enum USerMedicationsTypeImage: String {
    // Category
    case logPeriod = "blood_drop"
    case medication = "MedicationWhite"
    case procedure = "procedureWhite"
    case activity = "ActivityWhite"
    case symptoms = "SymtompsWhite"
    case pregnancyTest = "PregnancyTestWhite"

    var imageName: String {
        return self.rawValue
    }
}

enum UserMedicalOptionsType: String {
    // LOGPERIOD CATEGORY
    case logPeriod = "Log Period"
    case medication = "Medication"
    case procedure = "Procedure"
    case activity = "Activity"
    case symptoms = "Symptoms"
    case pregnancyTest = "Pregnancy Test"

    var image: String {
        switch self {
        case .logPeriod: return USerMedicationsTypeImage.logPeriod.imageName
        case .medication: return USerMedicationsTypeImage.medication.imageName
        case .procedure: return USerMedicationsTypeImage.procedure.imageName
        case .activity: return USerMedicationsTypeImage.activity.imageName
        case .symptoms: return USerMedicationsTypeImage.symptoms.imageName
        case .pregnancyTest: return USerMedicationsTypeImage.pregnancyTest.imageName
      }
    }
}

// MARK: -  For  return Images
enum UIImageType: String {
    case bloodDrop = "blood_drop"
    case myProfile = "myProfile"
    case settings = "settings"
    // for predicted dates on home
    case fertileWindow = "FertileWindow"
    case ovulation = "Ovulation"
    case predictedPeriod = "PredictedPeriod"
    var image: UIImage? {
        return UIImage(named: rawValue)
    }
}
