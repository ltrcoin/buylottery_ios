//
//  Extesion ResultDetailVC paging.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/10/5.
//  Copyright © 2018 kazy. All rights reserved.
//

import Foundation
import UIKit
extension ResultDetailViewController: UIScrollViewDelegate {
    
    func updatePositionContentPageView(_ isNext:Bool = true){

        if isNext && currentIndexPage <= numberPage - 2 && currentIndexPage > 1{
            
            bringToBottom(index: firstIndex, next: true)
            
            LeftTicketViewCTs[firstIndex].constant += CGFloat(numberPageContentView) * width
            RightTicketViewCTs[firstIndex].constant = totalWidthContent - LeftTicketViewCTs[firstIndex].constant - width
            self.scrollView.layoutIfNeeded()
            
            updateDataView(firstIndex)
            
            lastIndex = firstIndex
            
            firstIndex += 1
            firstIndex %= numberPageContentView
            
        } else if !isNext && currentIndexPage >= 1 && currentIndexPage < numberPage - 2 {
            
            bringToBottom(index: lastIndex, next: false)
            
            LeftTicketViewCTs[lastIndex].constant -= CGFloat(numberPageContentView) * width
            RightTicketViewCTs[lastIndex].constant = totalWidthContent - LeftTicketViewCTs[lastIndex].constant - width
            self.scrollView.layoutIfNeeded()
            
            updateDataView(lastIndex)
            
            firstIndex = lastIndex
            
            lastIndex -= 1
            if lastIndex < 0 {
                lastIndex = numberPageContentView - 1
            }
        }
        
    }
    
    
    
    func rightPage(){
        isPaging = true
        self.currentIndexPage += 1
        self.currentIndexContentPageView += 1
        self.currentIndexContentPageView %= self.numberPageContentView
        
        if self.currentIndexPage >= self.numberPage - 1 {
            self.currentIndexPage = self.numberPage - 1
        }
        updatePositionContentPageView(true)
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
            
            
            self.scrollView.contentOffset.x = CGFloat(self.currentIndexPage) * self.width
            
        }) { (done) in
            self.isPaging = false
        }
        
        updateNextPreviousView()
    }
    
    func leftPage(){
        isPaging = true
        self.currentIndexPage -= 1
        if self.currentIndexPage < 0 {
            self.currentIndexPage = 0
        }
        self.currentIndexContentPageView -= 1
        if self.currentIndexContentPageView < 0 {
            self.currentIndexContentPageView = self.numberPageContentView - 1
        }
        updatePositionContentPageView(false)
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
            
            self.scrollView.contentOffset.x = CGFloat(self.currentIndexPage) * self.width

        }) { (done) in
            self.isPaging = false
        }
        
        
        updateNextPreviousView()
    }
    
    func updateNextPreviousView(){
        if currentIndexPage == numberPage - 1 {
            previousAreaView.isHidden = true
        } else {
            previousAreaView.isHidden = false
        }
        
        if currentIndexPage == 0 {
            nextAreaView.isHidden = true
        } else {
            nextAreaView.isHidden = false
        }
        nextTimeLbl.text = "20:00"
        previousTimeLbl.text = "20:00"
        if currentIndexPage > 0 {
            nextDateLbl.text = prizeData[currentIndexPage - 1].drawDateStr
        }
        if currentIndexPage < prizeData.count - 1 {
            previousDateLbl.text = prizeData[currentIndexPage + 1].drawDateStr
        }
    }
    
    func bringToBottom(index:Int, next:Bool){
        
        if next {
            
            let n = (index + 1) % numberPageContentView
            self.scrollView.bringSubviewToFront(pageViews[n])
        } else {
            let p = index - 1 >= 0 ? index - 1 : numberPageContentView - 1
            
            self.scrollView.bringSubviewToFront(pageViews[p])
        }
        
        self.scrollView.bringSubviewToFront(pageViews[index])

    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        endDragPoint = self.scrollView.contentOffset
        
        if self.endDragPoint.x > self.beginDragPoint.x {
            rightPage()
        } else {
            leftPage()
        }
       
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        beginDragPoint = self.scrollView.contentOffset
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        self.scrollView.setContentOffset(scrollView.contentOffset, animated: false)
    }
    
}
