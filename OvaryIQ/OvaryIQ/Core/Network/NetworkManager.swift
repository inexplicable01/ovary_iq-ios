//
//  NetworkManager.swift
//  OvaryIQ
//
//  Created by Mobcoder on 25/01/22.
//

import Foundation
import Alamofire

class NetworkManager: EventLoop {

    var queueType: String?
    var isFileInProcess = false

    let reachabilityManager = NetworkReachabilityManager(host: "www.apple.com")

    private let sessionManager: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.timeoutIntervalForRequest = 120

        return Session(configuration: configuration)
    }()

    override init() {

        super.init()

        NetworkReachabilityManager()?.startListening(onUpdatePerforming: { (status) in
            dLog(message: "Network Status Changed: \(status)")
        })

        // -- This will spawn new network thread
        // -- and invoke EventLoop method
        self.start()
    }

    /*
     Used to add network request in network run loop
     */

    func addNetworkEvent(evobj: RestEngineEvents) {
        super.addEvent(evObj: evobj)
    }

    override func processQueuedEvent(evobj: Any) {

        fLog()

        if let restObject = evobj as? RestEngineEvents {
            if restObject.fastQueue {
                // process simple rest request
                if restObject.isCancelSentRequest {
                    self.cancelAllSentRequest()
                }

                self.processRestRequest(apiRequest:restObject.apiRequest)

            } else {
                // Slow Queue
                if restObject.uploadMultipart {

                    if let params = restObject.object as? [String: Any],
                       let keyName = params[APIParam.keyName] as? String,
                       let imageArr = params[keyName] as? [Any],
                        let header = restObject.apiRequest?.urlRequest?.allHTTPHeaderFields,
                        let urlStr = restObject.apiRequest?.urlRequest?.url?.absoluteString,
                        let method = restObject.apiRequest?.urlRequest?.method {
                        var newParams = params
                        newParams[APIParam.profile] = nil
                      //  newParams[keyName] = nil

                        self.multipartImageService(url: urlStr, data: [imageArr], withName: Array(repeating: keyName, count: [imageArr].count), fileName: Array(repeating: keyName + "/.png", count: [imageArr].count), mimeType: Array(repeating: "image/jpeg", count: [imageArr].count), header: header, method: .post, parameters: newParams)

                    } else if let params = restObject.object as? [String: Any],
                        let keyName = params[APIParam.keyName] as? String,
                        let imageArr = params[keyName] as? UIImage,
                        let keyName1 = params[APIParam.keyName1] as? String,
                        let videoArr = params[keyName1] as? URL,
                        let header = restObject.apiRequest?.urlRequest?.allHTTPHeaderFields,
                        let urlStr = restObject.apiRequest?.urlRequest?.url?.absoluteString,
                        let method = restObject.apiRequest?.urlRequest?.method {

                        var newParams = params
                        newParams[APIParam.keyName] = nil
                        newParams[keyName] = nil
                        newParams[APIParam.keyName1] = nil
                        newParams[keyName1] = nil

                        self.multipartImageVideoService(url: urlStr, data: [imageArr], videoData: [videoArr], withName: [keyName], withName1: [keyName1], fileName: [keyName + "/.png"], fileName1: nil, mimeType: ["image/jpeg"], mimeType1: nil, header: header, method: method, parameters: newParams)

                    } else if let params = restObject.object as? [String: Any],
                        let keyName = params[APIParam.keyName] as? String,
                        let imageArr = params[keyName] as? UIImage,
                        let header = restObject.apiRequest?.urlRequest?.allHTTPHeaderFields,
                        let urlStr = restObject.apiRequest?.urlRequest?.url?.absoluteString,
                        let method = restObject.apiRequest?.urlRequest?.method {

                        var newParams = params
                        newParams[APIParam.keyName] = nil
                        newParams[keyName] = nil

                        self.multipartImageService(url: urlStr, data: [imageArr], withName: [keyName], fileName: [keyName + "/.png"], mimeType: ["image/jpeg"], header: header, method: method, parameters: newParams)

                    } else if let params = restObject.object as? [String: Any],
                        let keyName = params[APIParam.keyName] as? String,
                        let imageArr = params[keyName] as? [UIImage],
                        let header = restObject.apiRequest?.urlRequest?.allHTTPHeaderFields,
                        let urlStr = restObject.apiRequest?.urlRequest?.url?.absoluteString,
                        let method = restObject.apiRequest?.urlRequest?.method {

                        var newParams = params
                        newParams[APIParam.keyName] = nil
                        newParams[keyName] = nil

                        self.multipartImageService(url: urlStr, data: imageArr, withName: Array(repeating: keyName, count: imageArr.count), fileName: Array(repeating: keyName + "/.png", count: imageArr.count), mimeType: Array(repeating: "image/jpeg", count: imageArr.count), header: header, method: method, parameters: newParams)

                    } else if let params = restObject.object as? [String: Any],
                        let keyName = params[APIParam.keyName] as? String,
                        let imageArr = params[keyName] as? URL,
                        let header = restObject.apiRequest?.urlRequest?.allHTTPHeaderFields,
                        let urlStr = restObject.apiRequest?.urlRequest?.url?.absoluteString,
                        let method = restObject.apiRequest?.urlRequest?.method {

                        var newParams = params
                        newParams[APIParam.keyName] = nil
                        newParams[keyName] = nil

                        self.multipartImageService(url: urlStr, data: [imageArr], withName: [keyName], fileName: nil, mimeType: nil, header: header, method: method, parameters: newParams)

                    } else if let params = restObject.object as? [String: Any],
                        let keyName = params[APIParam.keyName] as? String,
                        let imageArr = params[keyName] as? [URL],
                        let header = restObject.apiRequest?.urlRequest?.allHTTPHeaderFields,
                        let urlStr = restObject.apiRequest?.urlRequest?.url?.absoluteString,
                        let method = restObject.apiRequest?.urlRequest?.method{

                        var newParams = params
                        newParams[APIParam.keyName] = nil
                        newParams[keyName] = nil

                        self.multipartImageService(url: urlStr, data: imageArr, withName:  Array(repeating: keyName, count: imageArr.count), fileName: nil, mimeType: nil, header: header, method: method, parameters: newParams)

                    } else if let params = restObject.object as? [String: Any],
                        let header = restObject.apiRequest?.urlRequest?.allHTTPHeaderFields,
                        let urlStr = restObject.apiRequest?.urlRequest?.url?.absoluteString,
                        let method = restObject.apiRequest?.urlRequest?.method{

                        self.multipartImageService(url: urlStr, data: [], withName: [], fileName: [], mimeType: [], header: header, method: method, parameters: params)

                    }
                }
            }
        } else {
            //ERROR
        }
    }

    private func multipartImageService(url: String, data: [Any], withName: [String], fileName: [String]?, mimeType: [String]?, header: [String: String]? = nil, method: Alamofire.HTTPMethod, parameters: [String: Any]?) {

        var headerToSend = HTTPHeaders()
        if let headerTemp = header {
            headerToSend = HTTPHeaders(headerTemp)
        }

        AF.upload(
            multipartFormData: { multipartFormData in

                for (index,item) in data.enumerated() {
                    if let items = item as? UIImage {
                        multipartFormData.append(items.jpegData(compressionQuality: 0.5)!, withName: withName[index], fileName: fileName![index], mimeType: mimeType![index])
                    } else if let items = item as? URL {
                        multipartFormData.append(items, withName: withName[index])
                    }
                }

                for (key, value) in parameters! {
                    if let valueData = "\(value)".data(using: .utf8){
                        multipartFormData.append(valueData, withName: key)
                    }
                }
        },
            to: URL(string: url)!, method: .post, headers: headerToSend)
            .uploadProgress(closure: { (progress) in
                dLog(message: "Progress :: \(progress.fractionCompleted)")
                self.handleProgress(progress: progress.fractionCompleted, forFile: URL(string: url)!)
            })
            .response { resp in
                switch resp.result {
                case .success(let upload):

                    if let _ = upload {
                        dLog(message: "Pic Uploaded")
                        self.isFileInProcess = false
                        self.handleRestResponse(response: upload)
                        dLog(message: "response is \(upload)")
                    }

                case .failure(let error):
                    dLog(message: "Error :: \(error.localizedDescription)")
                    self.isFileInProcess = false
                    self.handleRestResponse(response: nil)
                    break
                }
        }
    }

    private func multipartImageVideoService(url: String, data: [Any], videoData: [Any], withName: [String], withName1: [String], fileName: [String]?, fileName1: [String]?, mimeType: [String]?, mimeType1: [String]?, header: [String:String]? = nil, method: Alamofire.HTTPMethod, parameters: [String:Any]?) {

        var headerToSend = HTTPHeaders()
        if let headerTemp = header {
            headerToSend = HTTPHeaders(headerTemp)
        }

        AF.upload(
            multipartFormData: { multipartFormData in

                for (index,item) in data.enumerated() {
                    if let items = item as? UIImage {
                        multipartFormData.append(items.jpegData(compressionQuality: 0.5)!, withName: withName[index], fileName: fileName![index], mimeType: mimeType![index])
                    } else if let items = item as? URL {
                        multipartFormData.append(items, withName: withName[index])
                    }
                }

                for (index,item) in videoData.enumerated() {
                    if let items = item as? URL {
                        multipartFormData.append(items, withName: withName1[index])
                    }
                }

                for (key, value) in parameters! {
                    if let valueData = "\(value)".data(using: .utf8){
                        multipartFormData.append(valueData, withName: key)
                    }
                }
        },
            to: URL(string: url)!, method: method ,headers: headerToSend)
            .uploadProgress(closure: { (progress) in
                dLog(message: "Progress :: \(progress.fractionCompleted)")
                self.handleProgress(progress: progress.fractionCompleted, forFile: URL(string: url)!)
            })
            .response { resp in
                switch resp.result {
                case .success(let upload):

                    if let _ = upload {
                        self.isFileInProcess = false
                        self.handleRestResponse(response: upload)
                        dLog(message: "Data Uploaded")
                    }

                case .failure(let error):
                    dLog(message: "Error :: \(error.localizedDescription)")
                    break
                }
        }
    }

    private func processUploadFileRequest(url: URL, apiRequest: URLRequestConvertible?) {

        self.isFileInProcess = true

        if let request = apiRequest {
            self.sessionManager.upload(url, with: request)
                .uploadProgress { progress in // main queue by default
                    self.handleProgress(progress: progress.fractionCompleted, forFile: url)
            }
            .responseData { responseData in
                self.isFileInProcess = false
            }
        } else {

        }
    }

    private func processDownloadFileRequest(serverURL: URL, localFileURL: URL) {

        self.isFileInProcess = true
        let destination: DownloadRequest.Destination = { _, _ in
            return (localFileURL, [.removePreviousFile, .createIntermediateDirectories])
        }

        AF.download(serverURL, to: destination)
            .downloadProgress { (progress) in
                self.handleProgress(progress: progress.fractionCompleted, forFile: localFileURL)
        }
        .downloadProgress(closure: { (progress) in
            self.handleProgress(progress: progress.fractionCompleted, forFile: serverURL)
        })
            .response { response in

                self.isFileInProcess = false

                if response.error == nil {
                    self.handleRestResponse(response: response)
                }
        }
    }

    private func processRestRequest(apiRequest: URLRequestConvertible?) {

        /*
        guard let method = apiRequest?.urlRequest?.httpMethod,
            let url = apiRequest?.urlRequest?.url,
            let metric = HTTPMetric(url: url, httpMethod: method == "GET" ? .get : .post) else { return }
        metric.setValue(url.absoluteString, forAttribute: "UrlStr")
        metric.start()
        */

        if let request = try? apiRequest?.asURLRequest() {
            self.sessionManager.request(request).responseJSON { (response) in
                if let dataa = response.data, let str = String(data: dataa, encoding: .utf8) {
                    dLog(message: "Processing Rest Request :: \(request)")
                    dLog(message: "Processing Rest Response :: \(str)")
                }

                if (response.response?.statusCode) != nil {
                    //metric.responseCode = statusCode
                }

                //metric.stop()
                self.handleRestResponse(response: response.value)
            }
        }
    }

    private func cancelAllSentRequest() {
        self.sessionManager.session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
            dataTasks.forEach { $0.cancel() }
            uploadTasks.forEach { $0.cancel() }
            downloadTasks.forEach { $0.cancel() }

            // Notify Scheduler to schedule next request
            RequestScheduler.shared.notifyThread(queueType: self.queueType!, response: Data() as Any)
        }
    }

    // MARK: - Handlers

    private func handleProgress(progress: Double, forFile url: URL) {
        RequestScheduler.shared.notifyProgress(queueType: queueType!, progress: progress, forFile: url)
    }

    private func handleRestResponse(response: DataResponse<Data, NSError>) {
        // Notify Scheduler to schedule next request
        RequestScheduler.shared.notifyThread(queueType: queueType!,response: response.data as Any)
    }

    private func handleRestResponse(response: Any?) {
        // Notify Scheduler to schedule next request
        RequestScheduler.shared.notifyThread(queueType: queueType!,response: response as Any)
    }

    private func handleRestResponse(response: [String: Any]) {
        // Notify Scheduler to schedule next request
        RequestScheduler.shared.notifyThread(queueType: queueType!,response: response as Any)
    }

    private func handleRestResponse(response: DownloadResponse<Any, NSError>) {
        // Notify Scheduler to schedule next request
        RequestScheduler.shared.notifyThread(queueType: queueType!,response: response as Any)
    }
}

