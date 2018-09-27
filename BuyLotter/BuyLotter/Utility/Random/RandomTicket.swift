//
//  RandomTicket.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/9/26.
//  Copyright © 2018 kazy. All rights reserved.
//

import Foundation
struct RandomTicket {
    
    func rand(min:Int, max:Int, number:Int) -> [Int]{
        var result:[Int] = []
        
        var check:[Int:Bool] = [:]
        
        for _ in 0..<number {
            var temp = Int(arc4random_uniform(UInt32(max - min))) + min
            while check[temp] != nil {
                temp = Int(arc4random_uniform(UInt32(max - min))) + min
            }
            check[temp] = true
            result.append(temp)
        }
        return result.sorted()
    }
    
    func randSystematicTicket(numberSystematic:Int,rule:TicketRuleModel) -> TicketModel {
        
        var sysmaticData = TicketModel()
        sysmaticData.normal = rand(min: rule.minNormal, max: rule.maxNormal, number: numberSystematic)
        sysmaticData.special = rand(min: rule.minSpecial, max: rule.maxSpecial, number: rule.numberSpecial)
        sysmaticData.isFull = true
        
        return sysmaticData
    }
    
    func randListTickets(number:Int,rule:TicketRuleModel) -> [TicketModel] {
        var data:[TicketModel] = []
        for i in 0..<number {
            var isDuplicate = false
            data.append(TicketModel())
            repeat {
                
                data[i].normal = rand(min: rule.minNormal, max: rule.maxNormal, number: rule.numberNormal)
                data[i].special = rand(min: rule.minSpecial, max: rule.maxSpecial, number: rule.numberSpecial)
                
                for j in 0..<i {
                    if data[i].special == data[j].special && data[i].normal == data[j].normal {
                        isDuplicate = true
                        break
                    }
                }
            } while isDuplicate
            
            data[i].isFull = true
        }
        return data
    }
    
}
