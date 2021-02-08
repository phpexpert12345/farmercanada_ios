//
//  WebApi.swift
//  HarpersKabab
//
//  Created by Arun Kumar Rathore on 10/06/20.
//  Copyright © 2020 arunkumar. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WebApi: NSObject {

    static let BASE_URL = "https://farmercanada.com/public/api/buyer/"
    
//    Web api code for hit api without authentication token
    static func webApiForPostRequestWithoutToken(_ url : String, _ params : Dictionary<String, String>, completion: @escaping (_ JSON: JSON)->()) {
        
//        let header = ["apikey" : "WebApi.API_KEY"]
//        let httpHeaders = HTTPHeaders(header)
        AF.upload(multipartFormData: { multiPart in
            for p in params {
                multiPart.append("\(p.value)".data(using: String.Encoding.utf8)!, withName: p.key)
            }
        }, to: url, method: .post, headers: nil) .uploadProgress(queue: .main, closure: { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler: { data in
            print("upload finished: \(data)")
            var swiftyJsonVar = JSON()
            if let json = data.data {
                do {
                    swiftyJsonVar = try JSON(data: json)
                }
                catch{
                print("JSON Error")
                    swiftyJsonVar = [:]
                }
            }else {
                swiftyJsonVar = [:]
            }
            if var topController = UIApplication.shared.keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                let loginVC = LoginVC.init(nibName: "LoginVC", bundle: nil)
                topController.navigationController?.pushViewController(loginVC, animated: true)
            }
            completion(swiftyJsonVar)
        })
    }
    
//    Web api code for hit api with authentication token
    static func webApiForPostRequestWithToken(_ url : String, _ params : Dictionary<String, Any>, completion: @escaping (_ JSON: JSON)->()) {
        
        let header = ["Authorization" : "Bearer \(UserDefaultOperations.getStringObject(ConstantStrings.AUTH_TOKEN))"]
        let httpHeaders = HTTPHeaders(header)
        AF.upload(multipartFormData: { multiPart in
            for p in params {
                
                multiPart.append("\(p.value)".data(using: String.Encoding.utf8)!, withName: p.key)
            }
            
        }, to: url, method: .post, headers: httpHeaders) .uploadProgress(queue: .main, closure: { progress in
            print("Upload Progress1111: \(progress.fractionCompleted)")
            
        }).responseJSON(completionHandler: { data in
            print("upload finished: \(data)")
            var swiftyJsonVar = JSON()
            if let json = data.data {
                do {
                    swiftyJsonVar = try JSON(data: json)
                }
                catch{
                print("JSON Error")
                    swiftyJsonVar = [:]
                }
            }else {
                swiftyJsonVar = [:]
            }
            completion(swiftyJsonVar)
        })
    }
    
//    Web api code for hit Get api with authentication token
    static func webApiForGetRequestWithToken(_ url : String, _ params : Dictionary<String, Any>, completion: @escaping (_ JSON: JSON)->()) {
        
        let header = ["Authorization" : "Bearer \(UserDefaultOperations.getStringObject(ConstantStrings.AUTH_TOKEN))"]
        let httpHeaders = HTTPHeaders(header)
        
        AF.request(url, method: .get, parameters: params, headers: httpHeaders)
            .responseJSON { (response) in
                var swiftyJsonVar = JSON()
                if let json = response.data {
                    do {
                        swiftyJsonVar = try JSON(data: json)
                        print(swiftyJsonVar)

                    }
                    catch{
                        swiftyJsonVar = [:]
                    }
                }else {
                    swiftyJsonVar = [:]
                }
                completion(swiftyJsonVar)
        }
    }
    
    
    static func webApiForPostRequestWithTokenanfImage(_ url : String, _ image : UIImage, _ profileImageKey: String,_ params : Dictionary<String, Any>, completion: @escaping (_ JSON: JSON)->()) {
        
        let imgData = image.jpegData(compressionQuality: 0.2)!
        let header = ["Authorization" : "Bearer \(UserDefaultOperations.getStringObject(ConstantStrings.AUTH_TOKEN))"]
        let httpHeaders = HTTPHeaders(header)
        AF.upload(multipartFormData: { multiPart in
            for p in params {
                
                multiPart.append("\(p.value)".data(using: String.Encoding.utf8)!, withName: p.key)
            }
            if(imgData.count > 0)
            {
              multiPart.append(imgData, withName: profileImageKey, fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
            }

        }, to: url, method: .post, headers: httpHeaders) .uploadProgress(queue: .main, closure: { progress in
            print("Upload Progresskkkkkkk: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler: { data in
            print("upload finished: \(data)")
            var swiftyJsonVar = JSON()
            if let json = data.data {
                do {
                    swiftyJsonVar = try JSON(data: json)
                }
                catch{
                print("JSON Error")
                    swiftyJsonVar = [:]
                }
            }else {
                swiftyJsonVar = [:]
            }
            completion(swiftyJsonVar)
        })
    }
}


enum WebApiName: String {
    case loginApi = "log-in"
    case signUpApi = "sign-up"
}
