//
//  Extension TicketHandPickView collectionView.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/9/28.
//  Copyright © 2018 kazy. All rights reserved.
//

import Foundation
import UIKit

extension TicketHandPickView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setupCollectionViews(){
        self.view.layoutIfNeeded()
        let w = (self.frame.width - 25 - 30 - CGFloat(numberColumn - 1) * 2) / CGFloat(numberColumn)
        
        cellSize = CGSize.init(width: w, height: w)
        
        print("cell size:\(cellSize)")
        
        setupCollectionView(cv: normalCollectionView)
        setupCollectionView(cv: specialCollectionView)
        
    }
    
    private func setupCollectionView(cv:UICollectionView){
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        cv.setCollectionViewLayout(layout, animated: true)
        cv.delegate = self
        cv.dataSource = self
        cv.register(UINib.init(nibName: cellId, bundle: nil), forCellWithReuseIdentifier: cellId)
        cv.backgroundColor = nil
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == normalCollectionView {
            return 70
        }
        if collectionView == specialCollectionView {
            return 26
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
        
        if collectionView == normalCollectionView {
            if !data.normal.contains(indexPath.item + 1) {
                if !data.isFull {
                    data.normal.append(indexPath.item + 1)
                    data.normal.sort()
                    if data.normal.count == ticketRule.numberNormal && data.special.count == ticketRule.numberSpecial {
                        data.isFull = true
                    }
                    
                    updateDataView()
                }
            } else {
                data.isFull = false
                if let i = data.normal.index(of: indexPath.item + 1) {
                    data.normal.remove(at: i)
                }
                updateDataView()
            }
            
            
        }
        if collectionView == specialCollectionView {
            if !data.special.contains(indexPath.item + 1){
                if !data.isFull {
                    data.special.append(indexPath.item + 1)
                    data.special.sort()
                    if data.normal.count == ticketRule.numberNormal && data.special.count == ticketRule.numberSpecial {
                        data.isFull = true
                    }
                    updateDataView()
                }
                
            } else {
                data.isFull = false
                if let i = data.special.index(of: indexPath.item + 1) {
                    data.special.remove(at: i)
                }
                updateDataView()
                
            }
        }
        
        delegate?.ticketHandPickView(self, toggleNumberAt: index)
        
    }
    
    func updateDataView() {
        
        if data.isFull {
            view.backgroundColor = colorFullBackground
            contentAreaView.backgroundColor = colorFullContent
            quitImg.tintColor = .white
            countDownNormalLbl.isHidden = true
            countDownSpecialLbl.isHidden = true
        } else {
            view.backgroundColor = colorNotFullBackground
            contentAreaView.backgroundColor = colorNotFullContent
            quitImg.tintColor = UIColor.darkGray
            countDownNormalLbl.isHidden = false
            countDownSpecialLbl.isHidden = false
            
            countDownNormalLbl.text = "+ Choose \(ticketRule.numberNormal - data.normal.count)"
            countDownSpecialLbl.text = "+ Choose \(ticketRule.numberSpecial - data.special.count)"
        }

        for j in 0...(ticketRule.maxNormal - ticketRule.minNormal) {
            if let cell = normalCollectionView.cellForItem(at: IndexPath.init(row: j, section: 0)) as? HandPickTicketCollectionViewCell {
                cell.isChoose = false
                if data.normal.contains(j + 1) {
                    cell.isChoose = true
                }
                cell.updateNormal()
            }
            
            
        }
        
        for j in 0...(ticketRule.maxSpecial - ticketRule.minSpecial) {
            
            if let cell = specialCollectionView.cellForItem(at: IndexPath.init(row: j, section: 0)) as? HandPickTicketCollectionViewCell {
                cell.isChoose = false
                if data.special.contains(j + 1) {
                    cell.isChoose = true
                }
                cell.updateSpecial()
            }
            
        }
    }
    
    func randomTicketAnimation() {
        data.isFull = false
        var count = 0
        
        func done(){
            print("🤩done anime")
            delegate?.ticketHandPickView(self, animationEndAt: index)
        }
        
        func runAnime(){
            data.normal = RandomTicket().rand(min: ticketRule.minNormal, max: ticketRule.maxNormal, number: ticketRule.numberNormal)
            data.special = RandomTicket().rand(min: ticketRule.minSpecial, max: ticketRule.maxSpecial, number: ticketRule.numberSpecial)
            updateDataView()
            
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
