//
//  Extension HandPickNumberTicketVC ticket delegate.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/9/28.
//  Copyright © 2018 kazy. All rights reserved.
//

import Foundation
import UIKit
extension HandPickNumberTicketViewController : TicketHandPickViewDelegate {
    func setupTicketView(){
        for i in 0..<ticketHandPickViews.count {
            ticketHandPickViews[i].delegate = self
            let index = Int(ticketViews[i].frame.minX) / Int(width)
            ticketHandPickViews[i].ticketRule = ticketRule
            ticketHandPickViews[i].data = data[index]
            ticketHandPickViews[i].index = index
            
            ticketHandPickViews[i].setupView()
        }
    }
    
    func ticketHandPickView(_ ticket: TicketHandPickView, animationEndAt index: Int) {
        data[index] = RandomTicket().randOneTicket(rule: ticketRule, data: data)
        ticket.data = data[index]
    }
    
    func ticketHandPickView(_ ticket: TicketHandPickView, animationBeginAt index: Int) {
        
    }
    
    func ticketHandPickView(_ ticket: TicketHandPickView, exitAt index: Int) {
        self.dismiss(animated: true, completion: nil)
    } 
    
    func ticketHandPickView(_ ticket: TicketHandPickView, resetAt index: Int) {
        data[index] = TicketModel()
        ticket.data = data[index]
    }
    
    func ticketHandPickView(_ ticket: TicketHandPickView, toggleNumberAt index: Int) {
        data[index] = ticket.data
    }

}
