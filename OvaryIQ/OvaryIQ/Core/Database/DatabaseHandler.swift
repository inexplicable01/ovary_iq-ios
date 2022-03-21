//
//  DatabaseHandler.swift
//  Ding
//
//  Created by Mobcoder Technologies Private Limited on 14/11/21.
//  Copyright © 2021 Naveen. All rights reserved.
//

import Foundation
import CoreData

//class DatabaseHandler: CoreDataManager {
//
//    static let shared = DatabaseHandler()
//
//    func saveUser(userInfo: UserInfo) -> Void {
//
//        let context = self.privateContext
//
//        context.performAndWait({
//
//            let userId = userInfo.userId
//
//            let predicate = NSPredicate(format: "userId == %@", userId as CVarArg)
//
//            var userData = self.fetchObject(entity: User.self, predicate: predicate, sortDescriptors: nil, context: context)
//
//            if userData == nil {
//                userData = self.createObject(entity: User.self, context: context)
//                userData?.userId = userId
//            }
//
//            if let value = userInfo.socialId {
//                userData?.socialId = value
//            }
//
//            if let value = userInfo.loginType {
//                userData?.loginType = Int64(value)
//            }
//
//            if let value = userInfo.email {
//                userData?.email = value
//            }
//
//            if let value = userInfo.countryCallingCode {
//                userData?.countryCallingCode = value
//            }
//
//            if let value = userInfo.phoneNo {
//                userData?.phoneNo = value
//            }
//
//            if let value = userInfo.firstName {
//                userData?.firstName = value
//            }
//
//            if let value = userInfo.lastName {
//                userData?.lastName = value
//            }
//
//            if let value = userInfo.dob {
//                userData?.dob = Int64(value)
//            }
//
//            if let value = userInfo.gender {
//                userData?.gender = Int64(value)
//            }
//
//            if let value = userInfo.city {
//                userData?.city = value
//            }
//
//            if let value = userInfo.state {
//                userData?.state = value
//            }
//
//            if let value = userInfo.country {
//                userData?.country = value
//            }
//
//            if let value = userInfo.address {
//                userData?.address = value
//            }
//
//            if let value = userInfo.zipCode {
//                userData?.zipCode = Int64(value)
//            }
//
//            if let value = userInfo.geoLocation {
//                let geoLocationLat = "\(value[1])"
//                let geoLocationLong = "\(value[0])"
//                userData?.geoLocation = geoLocationLat + "," + geoLocationLong
//            }
//
//            if let value = userInfo.height {
//                userData?.height = value
//            }
//
//            if let value = userInfo.ethnicity {
//                userData?.ethnicity = value
//            }
//
//            if let value = userInfo.favouriteVenues {
//                userData?.favouriteVenues = value.joined(separator: ",")
//            }
//
//            if let value = userInfo.businessName {
//                userData?.businessName = value
//            }
//
//            if let value = userInfo.publicBusinessName {
//                userData?.publicBusinessName = value
//            }
//
//            if let value = userInfo.registrationNumber {
//                userData?.registrationNumber = value
//            }
//
//            if let value = userInfo.businessTypes {
//                userData?.businessTypes = value.joined(separator: ",")
//            }
//
//            if let value = userInfo.businessEntertainments {
//                userData?.businessEntertainments = value.joined(separator: ",")
//            }
//
//            if let value = userInfo.isUserAccountExist {
//                userData?.isUserAccountExist = Int64(value)
//            }
//
//            if let value = userInfo.isBusinessAccountExist {
//                userData?.isBusinessAccountExist = Int64(value)
//            }
//
//            if let value = userInfo.isAccessToRewindFeatureEnable {
//                userData?.isAccessToRewindFeatureEnable = Int64(value)
//            }
//
//            if let value = userInfo.isPushNotificationEnable {
//                userData?.isPushNotificationEnable = Int64(value)
//            }
//
//            if let value = userInfo.isEmailNotificationEnable {
//                userData?.isEmailNotificationEnable = Int64(value)
//            }
//
//            if let value = userInfo.isTextNotificationEnable {
//                userData?.isTextNotificationEnable = Int64(value)
//            }
//
//            // Save User Profile Photos Start
//            var exisitingImages = userData?.userPhotos?.allObjects as? [DBUserPhoto]
//
//            if let userPhotos = userInfo.photos {
//                for userPhoto in userPhotos {
//
//                    let id = userPhoto.id
//
//                    if let url = userPhoto.url,
//                       let thumbUrl = userPhoto.thumbUrl {
//
//                        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
//                        var imageData = self.fetchObject(entity: DBUserPhoto.self, predicate: predicate, sortDescriptors: nil, context: context)
//
//                        if imageData == nil {
//                            imageData = self.createObject(entity: DBUserPhoto.self, context: context)
//                            imageData?.id = id
//                        }
//
//                        let orderId = url.components(separatedBy: "/").last ?? "0"
//                        imageData?.orderId = Int64(orderId) ?? 0
//                        imageData?.url = url
//                        imageData?.thumbUrl = thumbUrl
//
//                        userData?.addToUserPhotos(imageData!)
//
//                        exisitingImages?.removeAll(where: { (model) -> Bool in
//                            return model.id == id
//                        })
//
//                    }
//                }
//
//                if let exist = exisitingImages {
//                    exist.forEach { (model) in
//                        context.delete(model as NSManagedObject)
//                        userData?.removeFromUserPhotos(model)
//                    }
//                }
//            }
//            // Save User Profile Photos End
//
//            // Save Business Hours Start
//            var exisitingBusinessHours = userData?.businessHours?.allObjects as? [DBBusinessHour]
//
//            if let businessHours = userInfo.businessHours {
//                for businessHour in businessHours {
//                    if let day = businessHour.day {
//                        let startTime = businessHour.startTime
//                        let endTime = businessHour.endTime
//
//                        let predicate = NSPredicate(format: "day == %d", Int64(day) as CVarArg)
//                        var businessHoursData = self.fetchObject(entity: DBBusinessHour.self, predicate: predicate, sortDescriptors: nil, context: context)
//
//                        if businessHoursData == nil {
//                            businessHoursData = self.createObject(entity: DBBusinessHour.self, context: context)
//                            businessHoursData?.day = Int64(day)
//                        }
//
//                        businessHoursData?.startTime = Int64(startTime)
//                        businessHoursData?.endTime = Int64(endTime)
//
//                        userData?.addToBusinessHours(businessHoursData!)
//
//                        exisitingBusinessHours?.removeAll(where: { (model) -> Bool in
//                            return model.day == day
//                        })
//                    }
//
//
//                }
//
//                if let exist = exisitingBusinessHours {
//                    exist.forEach { (model) in
//                        context.delete(model as NSManagedObject)
//                        userData?.removeFromBusinessHours(model)
//                    }
//                }
//            }
//            // Save Business Hours End
//
//
//            self.saveChanges()
//        })
//    }
//
//    func fetchUserWith(userId: String, fromMain: Bool = false) -> UserInfo? {
//
//        var user: User?
//
//        let context = fromMain ? mainContext : privateContext
//
//        context.performAndWait {
//            let predicate = NSPredicate(format: "userId == %@", userId as CVarArg)
//            user = self.fetchObject(entity: User.self, predicate: predicate, sortDescriptors: nil, context: context)
//        }
//
//        guard let user = user, let userId = user.userId else {
//            dLog(message: "Error :: Unable to fetch UserInfo From DB")
//            return nil
//        }
//
//        var userInfo = UserInfo()
//        userInfo.userId = userId
//        userInfo.socialId = user.socialId
//        userInfo.loginType = Int(user.loginType)
//        userInfo.email = user.email
//        userInfo.countryCallingCode = user.countryCallingCode
//        userInfo.phoneNo = user.phoneNo
//        userInfo.firstName = user.firstName
//        userInfo.lastName = user.lastName
//        userInfo.dob = Int(user.dob)
//        userInfo.gender = Int(user.gender)
//        userInfo.city = user.city
//        userInfo.state = user.state
//        userInfo.country = user.country
//        userInfo.address = user.address
//        userInfo.zipCode = Int(user.zipCode)
//        userInfo.height = user.height
//        userInfo.ethnicity = user.ethnicity
//        userInfo.favouriteVenues = user.favouriteVenues?.components(separatedBy: ",")
//
//        let geoLocationLat = Double(user.geoLocation?.components(separatedBy: ",")[0] ?? "0.0") ?? 0.0
//        let geoLocationLong = Double(user.geoLocation?.components(separatedBy: ",")[1] ?? "0.0") ?? 0.0
//        userInfo.geoLocation = [geoLocationLong, geoLocationLat]
//
//        userInfo.businessName = user.businessName
//        userInfo.publicBusinessName = user.publicBusinessName
//        userInfo.registrationNumber = user.registrationNumber
//        userInfo.businessTypes = user.businessTypes?.components(separatedBy: ",")
//        userInfo.businessEntertainments = user.businessEntertainments?.components(separatedBy: ",")
//
//        userInfo.isUserAccountExist = Int(user.isUserAccountExist)
//        userInfo.isBusinessAccountExist = Int(user.isBusinessAccountExist)
//        userInfo.isAccessToRewindFeatureEnable = Int(user.isAccessToRewindFeatureEnable)
//        userInfo.isPushNotificationEnable = Int(user.isPushNotificationEnable)
//        userInfo.isEmailNotificationEnable = Int(user.isEmailNotificationEnable)
//        userInfo.isTextNotificationEnable = Int(user.isTextNotificationEnable)
//
//        var photos = [UserPhoto]()
//        if let userPhotos = user.userPhotos?.allObjects as? [DBUserPhoto] {
//            for userPhoto in userPhotos {
//                if let id = userPhoto.id,
//                   let url = userPhoto.url,
//                   let thumbUrl = userPhoto.thumbUrl {
//                    let orderId = userPhoto.orderId
//                    let photo = UserPhoto(orderId: Int(orderId), id: id, url: url, thumbUrl: thumbUrl)
//                    photos.append(photo)
//                }
//            }
//        }
//
//        userInfo.photos = photos.sorted(by: {$0.orderId < $1.orderId})
//
//       // var businessHours = [BusinessHour]()
////        if let dbBusinessHours = user.businessHours?.allObjects as? [DBBusinessHour] {
////            for dbBusinessHour in dbBusinessHours {
////                    let day = dbBusinessHour.day
////                    let startTime = dbBusinessHour.startTime
////                    let endTime = dbBusinessHour.endTime
////                    let businessHour = BusinessHour(day: Int(day), startTime: Int(startTime), endTime: Int(endTime))
////                    businessHours.append(businessHour)
////            }
////        }
//
//     //   userInfo.businessHours = businessHours
//
//        return userInfo
//    }
//
////    func deleteUserPhoto(photoId: String) {
////        let context = self.privateContext
////        context.perform {
////            let predicate = NSPredicate(format: "id == %@", photoId)
////            guard let carObject = self.fetchObject(entity: DBUserPhoto.self, predicate: predicate, sortDescriptors: nil, context: context) else {
////                dLog(message: "Error :: Unable to delete user photo with photo id :: \(photoId)")
////                return
////            }
////            context.delete(carObject)
////        }
////    }
//
//    func cleanDB()  {
//        self.deleteData(entity:  "User")
//        self.deleteData(entity:  "DBUserPhoto")
//        self.deleteData(entity:  "DBBusinessHour")
//    }
//
//    /*
//    func deleteUser(_ id: String) {
//        let context = privateContext
//        context.perform {
//            let predicate = NSPredicate(format: "user_id == %@", id)
//            guard let carObject = self.fetchObject(entity: User.self, predicate: predicate, sortDescriptors: nil, context: context) else {
//                LogHelper.debug("Error on delete user" as AnyObject)
//                return
//            }
//            context.delete(carObject)
//        }
//    }
//
//    func saveAddress(addressData: [[String: Any]]) -> Void {
//
//        let context = privateContext
//
//        context.performAndWait {
//
//            for address in addressData {
//
//                if let _id = address[API_PARAMS._id] as? String {
//
//                    //dLog(message: "Address Id :: \(_id)")
//
//                    let predicate = NSPredicate(format: "id == %@", _id as CVarArg)
//
//                    var addressData = self.fetchObject(entity: Address.self, predicate: predicate, sortDescriptors: nil, context: context)
//
//                    if(addressData == nil) {
//                        addressData = self.createObject(entity: Address.self, context: context)
//                        addressData?.id = _id
//                    } else {
//                        //dLog(message: "Id already exist :: \(addressData?.id)")
//                    }
//
//                    if let city = address[API_PARAMS.city] as? String {
//                        addressData?.city = city
//                    }
//
//                    if let state = address[API_PARAMS.state] as? String {
//                        addressData?.state = state
//                    }
//
//                    if let stateId = address[API_PARAMS.stateId] as? String {
//                        addressData?.stateId = stateId
//                    }
//
//                    if let countyFips = address[API_PARAMS.countyFips] as? String {
//                        addressData?.countyFips = countyFips
//                    }
//
//                    if let created = address[API_PARAMS.created] as? String {
//                        addressData?.created = created
//                    }
//
//                } else {
//                    dLog(message: "Error :: Save Address :: Id is nil or not string")
//                }
//            }
//
//            //self.saveChanges()
//            self.saveChanges { (error) in
//                if let errorL = error {
//                    dLog(message: "Error :: Save Address :: \(errorL.localizedDescription)")
//                }
//            }
//        }
//    }
//
//    func getAddressCount(fromMain: Bool = false) -> Int {
//
//        var totalCount: Int = 0
//
//        let context = fromMain ? mainContext : privateContext
//
//        context.performAndWait {
//
//            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: Address.className)
//            fetchRequest.predicate = nil
//            fetchRequest.resultType = NSFetchRequestResultType.countResultType
//
//            do {
//                totalCount = try context.count(for: fetchRequest)
//            } catch {
//
//            }
//        }
//
//        return totalCount
//    }
//
//    func fetchAddress(state: String, city: String?) -> [Address] {
//
//        var addressData = [Address]()
//
//        let context = mainContext
//
//        context.performAndWait {
//
//            var predicate = NSPredicate(format: "state contains[cd] %@", state)
//            var desciptor = NSSortDescriptor(key: "state", ascending: true)
//
//
//            if let searchCity = city{
//                 predicate = NSPredicate(format: "city contains[cd] %@ AND state == %@",searchCity,state)
//                 desciptor = NSSortDescriptor(key: "city", ascending: true)
//            }
//
//            addressData = self.fetchObjects(entity: Address.self, predicate: predicate, sortDescriptors: [desciptor], context: context)
//
//            if city == nil{
//                addressData = addressData.unique{$0.state}
//            }
//        }
//
//        return addressData
//    }
//
//    func fetchCitiesAlongWithStates(city: String?) -> [Address] {
//
//        var addressData = [Address]()
//
//        if city == nil {
//            return addressData
//        }
//
//        let context = mainContext
//
//        context.performAndWait {
//
//            //var predicate = NSPredicate(format: "state contains[cd] %@", state)
//            //var desciptor = NSSortDescriptor(key: "state", ascending: true)
//
//
//            if let searchCity = city {
//                let predicate = NSPredicate(format: "city contains[cd] %@",searchCity)
//                let desciptor = NSSortDescriptor(key: "city", ascending: true)
//
//                addressData = self.fetchObjects(entity: Address.self, predicate: predicate, sortDescriptors: [desciptor], context: context)
//
//                if city == nil {
//                    addressData = addressData.unique{$0.state}
//                }
//            }
//        }
//
//        return addressData
//    }
//
//    func fetchStatesAlongWithCities(state: String?) -> [Address] {
//
//        var addressData = [Address]()
//
//        if state == nil {
//            return addressData
//        }
//
//        let context = mainContext
//
//        context.performAndWait {
//
//            //var predicate = NSPredicate(format: "state contains[cd] %@", state)
//            //var desciptor = NSSortDescriptor(key: "state", ascending: true)
//
//
//            if let searchState = state {
//                let predicate = NSPredicate(format: "state contains[cd] %@", searchState)
//                let desciptor = NSSortDescriptor(key: "state", ascending: true)
//
//                addressData = self.fetchObjects(entity: Address.self, predicate: predicate, sortDescriptors: [desciptor], context: context)
//            }
//        }
//
//        return addressData
//    }
//     */
//}


