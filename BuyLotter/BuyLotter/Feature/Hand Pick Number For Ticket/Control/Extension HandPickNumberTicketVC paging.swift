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
        if self.scrollView.contentOffset.x - width > LeftTicketViewCTs[firstIndex].constant && indexCurrent < numberPage - 2 {
            
            bringToBottom(index: firstIndex, next: true)
            
            LeftTicketViewCTs[firstIndex].constant += CGFloat(numberPageContentView) * width
            RightTicketViewCTs[firstIndex].constant = totalWidthContent - LeftTicketViewCTs[firstIndex].constant - width + spaceTicket
            self.scrollView.layoutIfNeeded()
            
            updateDataView(firstIndex)
            
            lastIndex = firstIndex
            
            firstIndex += 1
            firstIndex %= numberPageContentView
            
        } else if scrollView.contentOffset.x < LeftTicketViewCTs[firstIndex].constant && beginDragPoint.x > 0 {
            
            bringToBottom(index: lastIndex, next: false)
            
            LeftTicketViewCTs[lastIndex].constant -= CGFloat(numberPageContentView) * width
            RightTicketViewCTs[lastIndex].constant = totalWidthContent - LeftTicketViewCTs[lastIndex].constant - width + spaceTicket
            self.scrollView.layoutIfNeeded()
            
            updateDataView(lastIndex)
            
            firstIndex = lastIndex
            
            lastIndex -= 1
            if lastIndex < 0 {
                lastIndex = numberPageContentView - 1
            }
        }
    }
    
    func bringToBottom(index:Int, next:Bool){
        
        if next {
            
            let n = (index + 1) % numberPageContentView
            self.scrollView.bringSubviewToFront(ticketViews[n])
        } else {
            let p = index - 1 >= 0 ? index - 1 : numberPageContentView - 1
            
            self.scrollView.bringSubviewToFront(ticketViews[p])
        }
        
        self.scrollView.bringSubviewToFront(ticketViews[index])
        
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        
        endDragPoint = self.scrollView.contentOffset
        print("begin drag:\(beginDragPoint): end drag:\(endDragPoint)")
        
        let index = CGFloat(Int(self.scrollView.contentOffset.x) / Int(width))
        currentIndexPage = Int(index)
        if index >= CGFloat(self.numberPage) - 1 {
            self.scrollView.contentOffset.x = CGFloat(self.numberPage - 1) * self.width
            self.currentIndexPage = self.numberPage - 1
            self.currentIndexContentPageView = self.numberPageContentView - 1
        }
        UIView.animate(withDuration: 0.15, animations: {
            if index >= CGFloat(self.numberPage) - 1 {
                self.scrollView.contentOffset.x = CGFloat(self.numberPage - 1) * self.width
                self.currentIndexPage = self.numberPage - 1
                self.currentIndexContentPageView = self.numberPageContentView - 1
            } else {
                if self.endDragPoint.x > self.beginDragPoint.x {
                    
                    self.scrollView.contentOffset.x = index * self.width + self.width
                    self.currentIndexPage += 1
                    self.currentIndexContentPageView += 1
                    self.currentIndexContentPageView %= self.numberPageContentView
                    
                } else {
                    
                    self.scrollView.contentOffset.x = index * self.width
                    self.currentIndexContentPageView -= 1
                    if self.currentIndexContentPageView < 0 {
                        self.currentIndexContentPageView = self.numberPageContentView - 1
                    }
                }
            }
        }) { (done) in
            print("😋 current index view frame:\(self.currentIndexPage):\(self.ticketViews[self.currentIndexContentPageView].frame)")
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        beginDragPoint = self.scrollView.contentOffset
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        self.scrollView.setContentOffset(scrollView.contentOffset, animated: false)
    }
    
}
