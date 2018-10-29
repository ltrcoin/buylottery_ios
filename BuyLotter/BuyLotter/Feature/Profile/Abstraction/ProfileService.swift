//
//  ProfileService.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/10/25.
//  Copyright © 2018 kazy. All rights reserved.
//

import Foundation
import Alamofire

struct ProfileService {
    
    func update(email:String, pwd:String, data:Dictionary<String, Any>,  portraitImg:UIImage?, passportImg:UIImage?, completion: @escaping (Bool, String, Dictionary<String,Any>?) -> Void ){
        
        var parameters: Parameters = [
            "email" : email,
            "password": pwd,
            "apikey" : Config.API_KEY
            ] as [String : String]
        
        if let temp = data["fullname"] as? String, temp != "" {
            parameters["fullname"] = temp
        }
        
        if let temp = data["tel"] as? String, temp != "" {
            parameters["tel"] = temp
        }
        
        if let temp = data["dob"] as? String, temp != "" {
            parameters["dob"] = temp
        }
        
        if let temp = data["address"] as? String, temp != "" {
            parameters["address"] = temp
        }
        
        if let temp = data["wallet_btc"] as? String, temp != "" {
            parameters["wallet_btc"] = temp
        }
        
        if let temp = data["wallet_ltr"] as? String, temp != "" {
            parameters["wallet_ltr"] = temp
        }
        
        if let temp = data["sex"] as? Int {
            parameters["sex"] = "\(temp)"
        }
        
        if let temp = data["country"] as? Int {
            parameters["country"] = "\(temp)"
        }
        
        print("parameters:\(parameters)")
  
        registerWithImages(parameters: parameters as! [String : String] ,portraitImg: portraitImg, passportImg: passportImg) { (done, msg, data) in
            completion(done, msg, data)
        }
        
    }
    
    private func registerWithImages(parameters: [String: String], portraitImg:UIImage?, passportImg:UIImage?, completion: @escaping (Bool, String, Dictionary<String,Any>) -> Void) {
        let url = Config.SERVER_LINK + "updateprofile"
        
        print("🤬\(passportImg)")
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
            
            if portraitImg != nil {
                
                guard let imageData = portraitImg?.resizedTo1MB()!.jpegData(compressionQuality: 1)  else {
                    print("Could not get JPEG representation of UIImage")
                    return
                }
                multipartFormData.append(imageData,
                                         withName: "portraitimage",
                                         fileName: "image\(1).jpg",
                    mimeType: "image/jpeg")
            }
            
            if passportImg != nil {
                guard let imageData = passportImg?.resizedTo1MB()!.jpegData(compressionQuality: 1) else {
                    print("Could not get JPEG representation of UIImage")
                    return
                }
                multipartFormData.append(imageData,
                                         withName: "passportimage",
                                         fileName: "image\(2).jpg",
                    mimeType: "image/jpeg")
            }
            
        }, to: url, encodingCompletion: { encodingResult in
            
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print("🤬 done:\(response.result.value)")
                    if let dataResponse = response.result.value as? Dictionary<String,Any> {
                        if let status = dataResponse["status"] as? Int, status == 200, let data = dataResponse["data"] as? Dictionary<String, Any> {
                            completion(true,"",data)
                        } else {
                            completion(false,"",[:])
                        }
                    } else {
                        completion(false,"",[:])
                    }
                }
            case .failure(let encodingError):
                print(encodingError)
            }
        })
    }
    
}
