//
//  Extension HandPickNumberTicketVC paging.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/9/27.
//  Copyright © 2018 kazy. All rights reserved.
//

import Foundation
import UIKit
extension HandPickNumberTicketViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let indexCurrent = Int(self.scrollView.contentOffset.x) / Int(width)
        print(indexCurrent)
        if self.scrollView.contentOffset.x - width > LeftTicketViewCTs[firstIndex].constant && indexCurrent < numberTicket - 2 {
            
            bringToBottom(index: firstIndex, next: true)
            
            LeftTicketViewCTs[firstIndex].constant += CGFloat(numberView) * width
            RightTicketViewCTs[firstIndex].constant = totalWidthContent - LeftTicketViewCTs[firstIndex].constant - width + spaceTicket
            self.scrollView.layoutIfNeeded()
            
            updateDataView(firstIndex)
            
            lastIndex = firstIndex
            
            firstIndex += 1
            firstIndex %= numberView
            
        } else if scrollView.contentOffset.x < LeftTicketViewCTs[firstIndex].constant && beginDragPoint.x > 0 {
            
            bringToBottom(index: lastIndex, next: false)
            
            LeftTicketViewCTs[lastIndex].constant -= CGFloat(numberView) * width
            RightTicketViewCTs[lastIndex].constant = totalWidthContent - LeftTicketViewCTs[lastIndex].constant - width + spaceTicket
            self.scrollView.layoutIfNeeded()
            
            updateDataView(lastIndex)
            
            firstIndex = lastIndex
            
            lastIndex -= 1
            if lastIndex < 0 {
                lastIndex = numberView - 1
            }
        }
    }
    
    func bringToBottom(index:Int, next:Bool){
        
        if next {
            
            let n = (index + 1) % numberView
            self.scrollView.bringSubview(toFront: ticketViews[n])
        } else {
            let p = index - 1 >= 0 ? index - 1 : numberView - 1
            
            self.scrollView.bringSubview(toFront: ticketViews[p])
        }
        
        self.scrollView.bringSubview(toFront: ticketViews[index])
        
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        
        endDragPoint = self.scrollView.contentOffset
        print("begin drag:\(beginDragPoint): end drag:\(endDragPoint)")
        
        let index = CGFloat(Int(self.scrollView.contentOffset.x) / Int(width))
        currentIndex = Int(index)
        
        UIView.animate(withDuration: 0.15, animations: {
            if index >= CGFloat(self.numberTicket) - 1 {
                self.scrollView.contentOffset.x = CGFloat(self.numberTicket - 1) * self.width
                self.currentIndex = self.numberTicket - 1
                self.currentView = self.numberView - 1
            } else {
                if self.endDragPoint.x > self.beginDragPoint.x {
                    
                    self.scrollView.contentOffset.x = index * self.width + self.width
                    self.currentIndex += 1
                    self.currentView += 1
                    self.currentView %= self.numberView
                    
                } else {
                    
                    self.scrollView.contentOffset.x = index * self.width
                    self.currentView -= 1
                    if self.currentView < 0 {
                        self.currentView = self.numberView - 1
                    }
                }
            }
        }) { (done) in
            print("😋 current index view frame:\(self.ticketViews[self.currentView].frame)")
            
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        beginDragPoint = self.scrollView.contentOffset
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        self.scrollView.setContentOffset(scrollView.contentOffset, animated: false)
    }
    
}
