//
//  TransactionService.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/10/18.
//  Copyright © 2018 kazy. All rights reserved.
//

import Foundation
import Alamofire

struct TransactionService {
    
    func getHistory(username:String, pwd:String, completion: @escaping ([TransactionHistoryModel]) -> Void ){
        print("😩 getWinningNumbers")
        let urlString = Config.SERVER_LINK + "transactionHistory"
        let parameter: Parameters = ["email":username,
                                      "password":pwd,
                                      "apikey" : Config.API_KEY
        ]
        
        var result:[TransactionHistoryModel] = []
        Alamofire.request(urlString, method: .post, parameters: parameter, encoding:JSONEncoding.default).responseJSON { (response) in
            if let dataResponse = response.result.value as? Dictionary<String,Any>,let status = dataResponse["status"] as? Int, status == 200, let data =  dataResponse["data"] as? [Dictionary<String,Any>]{
         
                for item in data {
                    if let gameId = item["game_id"] as? Int,let numbers = item["numbers"] as? String, let specials = item["special_numbers"] as? String, let timeStr = item["created_at"] as? String, let txHash = item["txhash"] as? String ,let price = item["price"] as? Double {
                        
                        var th = TransactionHistoryModel()
                        let tempN = numbers.split(separator: " ")
                        let tempS = specials.split(separator: " ")
                        
                        th.normals = tempN.map{Int($0) != nil ? Int($0)!: -1}
                        th.specials = tempS.map{Int($0) != nil ? Int($0)!: -1}
                        th.timeStr = timeStr
                        th.gameId = gameId
                        th.price = price
                        th.txHash = txHash
                        
                        result.insert(th, at: 0)
                    }
                }
                
            }
            completion(result)
        }
        
    }
    
}
