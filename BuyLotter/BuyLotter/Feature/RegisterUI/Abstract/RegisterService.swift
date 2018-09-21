//
//  RegisterService.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/9/14.
//  Copyright © 2018 kazy. All rights reserved.
//

import Foundation
import Alamofire
struct RegisterService {
    func register(email:String, pwd:String, fullname:String?, phone:String, walletBtc:String?, dob:String?, sex:Int, country:Int, address:String?, portraitImg:UIImage?, passportImg:UIImage?, completion: @escaping (Bool, String, Dictionary<String,Any>?) -> Void ){
        let urlString = Config.SERVER_LINK + "register"
        
        let headers: HTTPHeaders = [:]
        
        
        var parameters: Parameters = [
            "email" : email,
            "password": pwd,
            "tel": phone,
            "apikey" : Config.API_KEY
        ] as [String : String]
        
        if let temp = fullname, temp != "" {
            parameters["fullname"] = fullname!
        }
        
        if let temp = dob, temp != "" {
            parameters["dob"] = dob!
        }
        
        if let temp = address, temp != "" {
            parameters["address"] = address!
        }
        
        if let temp = walletBtc, temp != "" {
            parameters["wallet_btc"] = walletBtc!
        }
        
        if sex >= 0 {
            parameters["sex"] = "\(sex)"
        }
        
        if country >= 0 {
            parameters["country"] = "\(country)"
        }
        
        print("parameters:\(parameters)")
        
        if portraitImg != nil || passportImg != nil {
            registerWithImages(parameters: parameters as! [String : String] , headers: headers, portraitImg: portraitImg, passportImg: passportImg) { (done, msg, data) in
                completion(done, msg, data)
            }
        } else {
            
            Alamofire.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                    print("Progress: \(progress.fractionCompleted)")
                }
                .validate { request, response, data in
                    // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
                    return .success
                }.responseJSON { (response) in
                    print("\(response.result.value)")
                    if let dataResponse = response.result.value as? Dictionary<String,Any> {
                        guard let status = dataResponse["status"] as? Int,
                            let msg = dataResponse["msg"] as? String
                            else {
                                return
                                    completion(false, "", nil)
                        }
                        //                    if status == 200,let data = dataResponse["data"] as? Dictionary<String, Any> {
                        //                        completion(true,msg,data)
                        //                    } else {
                        //                        completion(false,msg,nil)
                        //                    }
                    }
            }
            
        }
        
        
        
    }
    
    private func registerWithImages(parameters: [String: String], headers: HTTPHeaders, portraitImg:UIImage?, passportImg:UIImage?, completion: @escaping (Bool, String, Dictionary<String,Any>?) -> Void) {
        let url = Config.SERVER_LINK + "register"
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
            
            if portraitImg != nil {
                guard let imageData = UIImageJPEGRepresentation(portraitImg!, 1) else {
                    print("Could not get JPEG representation of UIImage")
                    return
                }
                multipartFormData.append(imageData,
                                         withName: "portraitimage",
                                         fileName: "image\(1).jpg",
                    mimeType: "image/jpeg")
            }
            
            if passportImg != nil {
                guard let imageData = UIImageJPEGRepresentation(passportImg!, 1) else {
                    print("Could not get JPEG representation of UIImage")
                    return
                }
                multipartFormData.append(imageData,
                                         withName: "passportimage",
                                         fileName: "image\(2).jpg",
                    mimeType: "image/jpeg")
            }
            
        }, to: url, headers: headers, encodingCompletion: { encodingResult in
            
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print("done:\(response.result.value)")
                    if let data = response.result.value as? Dictionary<String,Any> {
                        if let status = data["status"] as? Int, status == 200 {
                            completion(true,"",nil)
                        } else {
                            completion(false,"",nil)
                        }
                    } else {
                        completion(false,"",nil)
                    }
                }
            case .failure(let encodingError):
                print(encodingError)
                
            }
        })
    }
    
}
