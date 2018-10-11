//
//  AccountService.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/10/8.
//  Copyright © 2018 kazy. All rights reserved.
//

import Foundation
import Alamofire

struct AccountService {
    func getBalance(username:String, pwd:String, completion: @escaping (Bool, String, Dictionary<String,Any>?) -> Void ){
        let urlString = Config.SERVER_LINK + "getbalance2"
        
        let headers: HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        
        let parameters: Parameters = ["email":username,
                                      "password":pwd,
                                      "apikey" : Config.API_KEY
        ]
        
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
                    if status == 200,let data = dataResponse["data"] as? Dictionary<String, Any> {
                       
                        completion(true,msg,data)
                    } else {
                        completion(false,msg,nil)
                    }
                }
        }
        
        
    }
}
