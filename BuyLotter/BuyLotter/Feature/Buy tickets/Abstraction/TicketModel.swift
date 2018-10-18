//
//  TicketModel.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/9/26.
//  Copyright © 2018 kazy. All rights reserved.
//

import Foundation
struct TicketModel {
    var normal:[Int] = []
    var special:[Int] = []
    var isFull = false
    
    func normalStr(_ space:String = "  ") -> String{
        var result = ""
        if normal.count > 1 {
            for i in 0..<normal.count - 1 {
                result += "\(normal[i])\(space)"
            }
            result += "\(normal[normal.count - 1])"
        } else if normal.count == 1 {
            result += "\(normal[0])"
        }
        
        return result
    }
    
    func specialStr(_ space:String = "  ") -> String{
        var result = ""
        if special.count > 1 {
            for i in 0..<special.count - 1 {
                result += "\(special[i])\(space)"
            }
            result += "\(special[special.count - 1])"
        } else if special.count == 1 {
            result += "\(special[0])"
        }
        
        return result
    }
    
}
