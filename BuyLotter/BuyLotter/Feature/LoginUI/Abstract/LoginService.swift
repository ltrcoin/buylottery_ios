//
//  LoginService.swift
//  LoginUI
//
//  Created by admin on 2018/9/5.
//  Copyright © 2018 CNCVN. All rights reserved.
//

import Foundation
import Alamofire 

struct LoginService {
    func login(username:String, pwd:String, completion: @escaping (Bool, String, Dictionary<String,Any>?) -> Void ){
        let urlString = Config.SERVER_LINK + "login"
       
        let parameters: Parameters = ["email":username,
                                      "password":pwd,
                                      "apikey" : Config.API_KEY
                                      ]
        
        Alamofire.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { (response) in
                print("\(response.result.value)")
                if let dataResponse = response.result.value as? Dictionary<String,Any> {
                    guard let status = dataResponse["status"] as? Int,
                    let msg = dataResponse["msg"] as? String
                    else {
                        completion(false, "", nil)
                        return
                    }
                    if status == 200,let data = dataResponse["data"] as? Dictionary<String, Any> {
                        UserDefaults.standard.setValue(username, forKey: "user-email")
                        UserDefaults.standard.setValue(pwd, forKey: "user-pwd")
                        completion(true,msg,data)
                    } else {
                        completion(false,msg,nil)
                    }
                }
        }
        
      
    }
}
