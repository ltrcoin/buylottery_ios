//
//  Extension HandPickNumberTicketVC collectionView.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/9/27.
//  Copyright © 2018 kazy. All rights reserved.
//

import Foundation
import UIKit
extension HandPickNumberTicketViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func setupCollectionView(){
        self.view.layoutIfNeeded()
        let w = (self.scrollView.frame.width - 25 - space - CGFloat(numberColumn - 1) * 2) / CGFloat(numberColumn)
        cellSize = CGSize.init(width: w, height: w)
        
        print("cell size:\(cellSize)")

        for ct in heightNormalCTs {
            ct.constant = (cellSize.height + 2) * CGFloat((ticketRule.maxNormal - ticketRule.minNormal) / numberColumn + 1)
        }
        
        for ct in heightSpecialCTs {
            ct.constant = (cellSize.height + 2) * CGFloat((ticketRule.maxSpecial - ticketRule.minSpecial) / numberColumn + 1)
        }
        
        
        
        for cv in normalCollectionViews {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 2
            layout.minimumLineSpacing = 2
            cv.setCollectionViewLayout(layout, animated: true)
            cv.delegate = self
            cv.dataSource = self
            cv.register(UINib.init(nibName: cellId, bundle: nil), forCellWithReuseIdentifier: cellId)
            cv.backgroundColor = nil
        }
        
        for cv in specialCollectionViews {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 2
            layout.minimumLineSpacing = 2
            cv.setCollectionViewLayout(layout, animated: true)
            cv.delegate = self
            cv.dataSource = self
            cv.register(UINib.init(nibName: cellId, bundle: nil), forCellWithReuseIdentifier: cellId)
            cv.backgroundColor = nil
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if normalCollectionViews.contains(collectionView) {
            return ticketRule.maxNormal - ticketRule.minNormal + 1
        }
        if specialCollectionViews.contains(collectionView) {
            return ticketRule.maxSpecial - ticketRule.minSpecial + 1
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HandPickTicketCollectionViewCell
        
        cell.numberLbl.text = "\(indexPath.item + 1)"
    
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(" selected: \(indexPath.row)")
        let cell = collectionView.cellForItem(at: indexPath) as! HandPickTicketCollectionViewCell
        if normalCollectionViews.contains(collectionView) {
            if !data[currentIndex].normal.contains(indexPath.item + 1) {
                if !data[currentIndex].isFull {
                    data[currentIndex].normal.append(indexPath.item + 1)
                    data[currentIndex].normal.sort()
                    if data[currentIndex].normal.count == ticketRule.numberNormal && data[currentIndex].special.count == ticketRule.numberSpecial {
                        data[currentIndex].isFull = true
                    }
                    
                    updateDataViews()
                }
            } else {
                data[currentIndex].isFull = false
                if let i = data[currentIndex].normal.index(of: indexPath.item + 1) {
                    data[currentIndex].normal.remove(at: i)
                }
                updateDataViews()
            }
            
            
        }
        if specialCollectionViews.contains(collectionView) {
            if !data[currentIndex].special.contains(indexPath.item + 1) {
                if !data[currentIndex].isFull {
                    data[currentIndex].special.append(indexPath.item + 1)
                    data[currentIndex].special.sort()
                    if data[currentIndex].normal.count == ticketRule.numberNormal && data[currentIndex].special.count == ticketRule.numberSpecial {
                        data[currentIndex].isFull = true
                    }
                    updateDataViews()
                }
                
            } else {
                data[currentIndex].isFull = false
                if let i = data[currentIndex].special.index(of: indexPath.item + 1) {
                    data[currentIndex].special.remove(at: i)
                }
                updateDataViews()
            }
        }
        
    }
    
    func updateDataViews(){
        for i in 0..<ticketViews.count {
            updateDataView(i)
        }
    }
    
    func updateDataView(_ i:Int) {
        let index = Int(ticketViews[i].frame.minX) / Int(width)
        if data[index].isFull {
            backgroundTicketViews[i].backgroundColor = colorFullBackground
            contentAreaTicketViews[i].backgroundColor = colorFullContent
            quitImgs[i].tintColor = .white
        } else {
            backgroundTicketViews[i].backgroundColor = colorNotFullBackground
            contentAreaTicketViews[i].backgroundColor = colorNotFullContent
            quitImgs[i].tintColor = UIColor.darkGray
        }
        noTicketLbls[i].text = "Line: \(index + 1)/\(numberTicket)"
        for j in 0...(ticketRule.maxNormal - ticketRule.minNormal) {
            if let cell = normalCollectionViews[i].cellForItem(at: IndexPath.init(row: j, section: 0)) as? HandPickTicketCollectionViewCell {
                cell.isChoose = false
                if data[index].normal.contains(j + 1) {
                    cell.isChoose = true
                }
                cell.updateNormal()
            }
            
            
        }
        
        for j in 0...(ticketRule.maxSpecial - ticketRule.minSpecial) {
            
            if let cell = specialCollectionViews[i].cellForItem(at: IndexPath.init(row: j, section: 0)) as? HandPickTicketCollectionViewCell {
                cell.isChoose = false
                if data[index].special.contains(j + 1) {
                    cell.isChoose = true
                }
                cell.updateSpecial()
            }
            
        }
    }
    
    func randomTicketAnimation() {
        data[currentIndex].isFull = false
        var count = 0
        
        func done(){
            print("🤩done")
            data[currentIndex] = RandomTicket().randOneTicket(rule: ticketRule, data: data)
            updateDataView(currentView)
        }
        
        func runAnime(){
            data[currentIndex].normal = RandomTicket().rand(min: ticketRule.minNormal, max: ticketRule.maxNormal, number: ticketRule.numberNormal)
            data[currentIndex].special = RandomTicket().rand(min: ticketRule.minSpecial, max: ticketRule.maxSpecial, number: ticketRule.numberSpecial)
            updateDataView(currentView)
            
            DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + 0.1) {
                count += 1
                if count <= 4 {
                    DispatchQueue.main.async {
                        runAnime()
                    }
                } else {
                    DispatchQueue.main.async {
                        done()
                    }
                }
            }
        }
        
        runAnime()
    }
    
}
