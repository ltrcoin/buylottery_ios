//
//  CheckoutService.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/10/12.
//  Copyright © 2018 kazy. All rights reserved.
//

import Foundation
import Alamofire

struct CheckoutService {
    func checkout(email:String, pwd:String, ticketsData:[TicketModel], completion: @escaping (Bool,String,String) -> Void ){
        let urlString = Config.SERVER_LINK + "buytickets"
        
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var pJson = "[{\"email\":\"\(email)\",\"password\":\"\(pwd)\",\"apikey\":\"\(Config.API_KEY)\"},"
        
        
        if ticketsData.count > 1 {
            for i in 0..<ticketsData.count - 1 {
                pJson += "{\"game_id\":3,\"numbers\":\"\(ticketsData[i].normalStr(" "))\",\"special_numbers\":\"\(ticketsData[i].specialStr(" "))\",\"price\":2000},"
            }
        }
        if ticketsData.count > 0 {
            pJson += "{\"game_id\":3,\"numbers\":\"\(ticketsData[ticketsData.count - 1].normalStr(" "))\",\"special_numbers\":\"\(ticketsData[ticketsData.count - 1].specialStr(" "))\",\"price\":2000}"
        }
        pJson += "]"
        
        print("json:\(pJson)")
    
        let data = (pJson.data(using: .utf8))! as Data
        
        request.httpBody = data
        
        Alamofire.request(request).responseJSON { (response) in
            
            print(response.result.value)
            
            if let json = response.result.value as? Dictionary<String,Any> {
                if let data = json["data"] as? Dictionary<String,Any>, let txhash = data["TxHash"] as? String {
                    completion(true, "" ,txhash)
                } else if let msg = json["msg"] as? String {
                    completion(false, msg ,"") 
                }
                
            } else {
                completion(false, "Error network" ,"") 
            }
            
            
        }
        
    }
}
