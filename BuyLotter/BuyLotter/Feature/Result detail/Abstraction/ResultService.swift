//
//  ResultService.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/10/11.
//  Copyright © 2018 kazy. All rights reserved.
//

import Foundation
import Alamofire
struct ResultService {
    func getWinningNumbers( completion: @escaping ([PrizeModel]) -> Void ){
        print("😩 getWinningNumbers")
        let urlString = Config.SERVER_LINK + "winningnumbers"
        let parameter:Parameters = ["game_id":3]
        var result:[PrizeModel] = []
        Alamofire.request(urlString, method: .post, parameters: parameter, encoding:JSONEncoding.default).responseJSON { (response) in
            if let dataResponse = response.result.value as? [Dictionary<String,Any>] {
                for data in dataResponse {
                    if let numbers = data["numbers"] as? String, let specials = data["special_numbers"] as? String, let dateStr = data["draw_date"] as? String {
                        var prize = PrizeModel()
                        let tempN = numbers.split(separator: ",")
                        let tempS = specials.split(separator: ",")
                        prize.normalNumbers = tempN.map{Int($0)!}
                        prize.specialNumbers = tempS.map{Int($0)!}
                        prize.drawDateStr = dateStr
                        
                        result.insert(prize, at: 0)
                    }
                }
                completion(result)
            }
        }
    
    }
}
