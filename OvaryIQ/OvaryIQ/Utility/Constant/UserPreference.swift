//
//  UserPreference.swift
//  OvaryIQ
//
//  Created by Mobcoder on 25/01/22.
//

import Foundation
class UserPreference {

    let DEFAULTSKEY = "MAIDFINDER_KEYS"
    static let shared = UserPreference()
    var data : AuthSignUpDataModel? {
        get {
            return fetchData()
        }
        set {
            if let value = newValue {
                saveData(value)
            } else {
                removeData(keys: DEFAULTSKEY)
            }
        }
    }
    func saveData(_ value: AuthSignUpDataModel) {
        guard let data = JSONHelper<AuthSignUpDataModel>().getData(model: value) else {
            removeData(keys: DEFAULTSKEY)
            return
        }
        UserDefaults.standard.set(data, forKey: DEFAULTSKEY)
    }

    func fetchData() -> AuthSignUpDataModel? {

        guard let data = UserDefaults.standard.data(forKey: DEFAULTSKEY) as? Data else {
            return nil
        }
        return JSONHelper<AuthSignUpDataModel>().getCodableModel(data: data)
    }

    func removeData(keys: String) {
        UserDefaults.standard.removeObject(forKey: keys)
    }
    class var deviceToken: String? {
         set {
            UserPreference.saveValue(value: newValue, key: .deviceToken)
         } get {
             return UserPreference.getValue(.deviceToken) as? String
         }
     }
    private class func saveValue(value: Any?, key: DefaultKeys) {
        var data: Data?
        if let value = value {
            data = try? NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: true)
        }
        UserDefaults.standard.set(data, forKey: key.rawValue)
         UserDefaults.standard.synchronize()
    }

    private class func getValue(_ key: DefaultKeys) -> Any {
        if let data = UserDefaults.standard.value(forKey: key.rawValue) as? Data {
            if let value = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) {
                return value ?? ""
            }
            else {
                return ""
            }
        } else {
            return ""
        }
    }
}
