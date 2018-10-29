//
//  BuyLTRCoinService.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/10/22.
//  Copyright © 2018 kazy. All rights reserved.
//

import Foundation
import Alamofire

struct BuyLTRCoinService {
    func buyLTR(username:String, pwd:String, ltr:String, completion: @escaping (Bool, String, String) -> Void ){
        let urlString = Config.SERVER_LINK + "buyltr"
        
        let parameters: Parameters = ["email":username,
                                      "password":pwd,
                                      "apikey" : Config.API_KEY,
                                      "ltr_tobuy":ltr
        ]
        
        Alamofire.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { (response) in
                print("\(response.result.value)")
                if let dataResponse = response.result.value as? Dictionary<String,Any>, let status = dataResponse["status"] as? Int, status == 200 {
                    
                    if let data = dataResponse["data"] as? [Dictionary<String, Any>] {
                        if let ethTxhash = data[0]["TxHash"] as? String, let ltrTxhash = data[1]["TxHash"] as? String {
                            completion(true, ethTxhash, ltrTxhash)
                        } else {
                            completion(false, "", "")
                        }
                    } else {
                        completion(false, "", "")
                    }
                } else {
                     completion(false, "", "")
                }
        }
   
    }
    
    
    func getRatio(completion: @escaping (Double) -> Void ){
        let urlString = "https://api.coinmarketcap.com/v1/ticker/ethereum/"
        
        Alamofire.request(urlString)
            .responseJSON { (response) in

                print("\(response.result.value)")
                if let dataResponse = response.result.value as? [Dictionary<String,Any>], let ratioStr = dataResponse[0]["price_usd"] as? String, let ratio = Double(ratioStr) {
                        completion(ratio)
                    }
        }
        
        
    }
}
