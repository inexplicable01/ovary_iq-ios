//
//  CoreDataManager.swift
//  Ding
//
//  Created by Mobcoder Technologies Private Limited on 14/11/21.
//  Copyright © 2021 Naveen. All rights reserved.
//

import Foundation
import CoreData


// MARK: - CoreDataManager

/**
 Responsible for setting up the Core Data stack. Also provides some convenience methods for fetching, deleting, and saving.
 */
class CoreDataManager:NSObject {

    static fileprivate let mustCallSetupMethodErrorMessage = "CoreDataManager must be set up using setUp(withDataModelName:bundle:persistentStoreType:) before it can be used."

    var _privateContext: NSManagedObjectContext? = nil
    var _writerContext: NSManagedObjectContext? = nil
    var _mainContext: NSManagedObjectContext? = nil

    var _managedObjectModel: NSManagedObjectModel? = nil
    var _persistentStoreCoordinator: NSPersistentStoreCoordinator? = nil

    // MARK: - Init Methods

    override init(){
        super.init()
        addObservers()
    }

    // MARK: - Properties

    func addObservers(){

        NotificationCenter.default.addObserver(self, selector: #selector(contextDidSavePrivateQueueContext), name: .NSManagedObjectContextDidSave, object: privateContext)

        NotificationCenter.default.addObserver(self, selector: #selector(contextDidSaveMainQueueContext), name: .NSManagedObjectContextDidSave, object: mainContext)
    }

    static let dataModelName = "Ding"

    /// The logger to use for logging errors caught internally. A default logger is used if a custom one isn't provided. Assigning nil to this property prevents CoreDataManager from emitting any logs to the console.
    //public static var errorLogger: CoreDataManagerErrorLogger? = DefaultLogger()

    /// The value to use for `fetchBatchSize` when fetching objects.
    public var defaultFetchBatchSize = 50


    // MARK: - Core Data Stack

    @objc func contextDidSavePrivateQueueContext(notification:Notification){

        DispatchQueue.main.async {
            let mainContext  = self.mainContext
            mainContext.performAndWait {
                mainContext.mergeChanges(fromContextDidSave: notification)
                do{
                    try mainContext.save()
                }catch let error {
                    // log error
                    self.log(error: error)
                }
            }
        }
    }

    @objc func contextDidSaveMainQueueContext(notification:Notification){

        let writerContext = self.writerContext

        writerContext.perform {
            writerContext.mergeChanges(fromContextDidSave: notification)

            do{
                try writerContext.save()
            }catch let error {
                // log error
                self.log(error: error)
            }
        }
    }

    var applicationDocumentsDirectory: URL = {

        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count - 1]
    }()

    var managedObjectModel: NSManagedObjectModel = {

        guard let modelURL = Bundle.main.url(forResource: dataModelName, withExtension: "momd") else {
            // fatalError("Failed to locate data model schema file.")
            queuedFatalError("Failed to locate data model schema file.")
        }

        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            queuedFatalError("Failed to created managed object model")
        }

        return managedObjectModel
    }()

    var persistentStoreCoordinator: NSPersistentStoreCoordinator{

        if _persistentStoreCoordinator == nil {


            _persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel:self.managedObjectModel)

            let url = self.applicationDocumentsDirectory.appendingPathComponent("\(CoreDataManager.dataModelName).sqlite")

            dLog(message: "DB  Path :: \(url)")

            let options = [
                NSMigratePersistentStoresAutomaticallyOption: true,
                NSInferMappingModelAutomaticallyOption: true
            ]

            do {
                try _persistentStoreCoordinator!.addPersistentStore(ofType:NSSQLiteStoreType, configurationName: nil, at: url, options: options)
            }
            catch let error as NSError {
                queuedFatalError("Failed to initialize the application's persistent data: \(error.localizedDescription)")
            }
            catch {
                queuedFatalError("Failed to initialize the application's persistent data")
            }
        }

        return _persistentStoreCoordinator!
    }

    fileprivate var writerContext: NSManagedObjectContext {

        if _writerContext == nil {
            _writerContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
            _writerContext!.persistentStoreCoordinator = self.persistentStoreCoordinator
        }

        return _writerContext!
    }

    public var privateContext: NSManagedObjectContext{

        if(_privateContext == nil){
            _privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
            _privateContext!.parent = self.mainContext
        }

        return _privateContext!
    }

    /// A MainQueueConcurrencyType context whose parent is a PrivateQueueConcurrencyType Writer Context. The PrivateQueueConcurrencyType Writer context is the root context.
    public var mainContext: NSManagedObjectContext {

        if(_mainContext == nil){
            _mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            _mainContext!.parent = self.writerContext
        }

        return _mainContext!
    }


    // MARK: Fetching

    /**
     This is a convenience method for performing a fetch request. Note: Errors thrown by executeFetchRequest are suppressed and logged in order to make usage less verbose. If detecting thrown errors is needed in your use case, you will need to use Core Data directly.

     - parameter entity:          The NSManagedObject subclass to be fetched.
     - parameter predicate:       A predicate to use for the fetch if needed (defaults to nil).
     - parameter sortDescriptors: Sort descriptors to use for the fetch if needed (defaults to nil).
     - parameter context:         The NSManagedObjectContext to perform the fetch with.

     - returns: A typed array containing the results. If executeFetchRequest throws an error, an empty array is returned.
     */
    public  func fetchObjects<T: NSManagedObject>(entity: T.Type, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil, context: NSManagedObjectContext) -> [T] {

        let request = NSFetchRequest<T>(entityName: String(describing: entity))
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        request.fetchBatchSize = defaultFetchBatchSize
        request.includesPropertyValues = false
        request.returnsObjectsAsFaults = false

        do {
            return try context.fetch(request)
        }
        catch let error as NSError {
            log(error: error)
            return [T]()
        }
    }

    /**
     This is a convenience method for performing a fetch request that fetches a single object. Note: Errors thrown by executeFetchRequest are suppressed and logged in order to make usage less verbose. If detecting thrown errors is needed in your use case, you will need to use Core Data directly.

     - parameter entity:          The NSManagedObject subclass to be fetched.
     - parameter predicate:       A predicate to use for the fetch if needed (defaults to nil).
     - parameter sortDescriptors: Sort descriptors to use for the fetch if needed (defaults to nil).
     - parameter context:         The NSManagedObjectContext to perform the fetch with.

     - returns: A typed result if found. If executeFetchRequest throws an error, nil is returned.
     */
    public  func fetchObject<T: NSManagedObject>(entity: T.Type, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil, context: NSManagedObjectContext) -> T? {

        let request = NSFetchRequest<T>(entityName: String(describing: entity))

        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        request.fetchLimit = 1

        do {
            return try context.fetch(request).first
        }
        catch let error as NSError {
            log(error: error)
            return nil
        }
    }

    public  func createObject<T: NSManagedObject>(entity: T.Type, context: NSManagedObjectContext) -> T? {
        return NSEntityDescription.insertNewObject(forEntityName: T.className, into: context) as? T
    }

    // MARK: Deleting

    /**
     Iterates over the objects and deletes them using the supplied context.

     - parameter objects: The objects to delete.
     - parameter context: The context to perform the deletion with.
     */
    public  func delete(_ objects: [NSManagedObject]) {

        self.privateContext.perform {
            for object in objects {
                self.privateContext.delete(object)
            }
        }
    }

    /**
     For each entity in the model, fetches all objects into memory, iterates over each object and deletes them using the main context. Note: Errors thrown by executeFetchRequest are suppressed and logged in order to make usage less verbose. If detecting thrown errors is needed in your use case, you will need to use Core Data directly.
     */
    public func deleteAllObjects() {

        self.privateContext.perform {

            for entityName in self.managedObjectModel.entitiesByName.keys {

                // No need to delete address table
                if entityName == "Address"{
                    continue
                }

                let request = NSFetchRequest<NSManagedObject>(entityName: entityName)
                request.includesPropertyValues = false

                do {
                    for object in try self.privateContext.fetch(request) {
                        self.privateContext.delete(object)
                    }
                }
                catch let error as NSError {
                    self.log(error: error)
                }
            }
        }
    }

    // MARK: Saving

    /**
     Saves changes to the persistent store.

     - parameter synchronously: Whether the main thread should block while writing to the persistent store or not.
     - parameter completion:    Called after the save on the private context completes. If there is an error, it is called immediately and the error parameter is populated.
     */
    public  func saveChanges(completion: ((Error?) -> Void)? = nil) {

        if self.privateContext.hasChanges {

            //self.privateContext.performAndWait {}
            do {
                try self.privateContext.save()
                completion?(nil)
            }
            catch let error {
                completion?(error)
            }

        } else {
            //CoreDataManager.log no changes found in context
            let error = NSError(domain: "", code: 401, userInfo: [ NSLocalizedDescriptionKey: "No changes found in context"])
            completion?(error)
        }
    }

    // MARK: Logging

    private func log(error: Error, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {

        //errorLogger?.log(error: error, file: file, function: function, line: line)
    }


    public func resetDatabase() {

        writerContext.performAndWait {

            let persistentStores = self.persistentStoreCoordinator.persistentStores

            persistentStores.forEach { (store) in

                do{
                    try self.persistentStoreCoordinator.remove(store)

                    if let path = store.url?.path{
                        try FileManager.default.removeItem(atPath: path)
                    }

                }catch let error{
                    //print("Error :: \(error.localizedDescription)")
                    dLog(message: "Error :: \(error.localizedDescription)")
                }
            }

            _writerContext = nil
            _mainContext = nil
            _privateContext = nil
            _managedObjectModel = nil
            _persistentStoreCoordinator = nil

            NotificationCenter.default.removeObserver(self)

            // again add the observers
            addObservers()
        }
    }

    func deleteData(entity: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false

        let deleteRequest = NSBatchDeleteRequest.init(fetchRequest: fetchRequest)

        do {
            guard let context = _mainContext else {return}
            try self._persistentStoreCoordinator?.execute(deleteRequest, with: context)
        } catch let error {
            //print("Detele all data in \(entity) error :", error)
            dLog(message: "Delete all data in \(entity) error :: \(error)")
        }
    }
}

