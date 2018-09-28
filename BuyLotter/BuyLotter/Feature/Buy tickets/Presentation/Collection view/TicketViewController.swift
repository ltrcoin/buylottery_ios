//
//  TicketViewController.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/9/25.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit
import KTCenterFlowLayout

class TicketViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellId = "TicketCollectionViewCell"
    let systematicCellId = "SystematicCollectionViewCell"
    
    var numberTicket = 8 {
        didSet {
            if data.count < numberTicket {
                for _ in 0..<(numberTicket - data.count) {
                    data.append(TicketModel())
                }
                
            } else {
                for _ in 0..<(data.count - numberTicket) {
                    data.removeLast()
                }
            }
        }
    }
    
    var ticketRule = TicketRuleModel()
    
    var maxCol = 5
    var cellSpace:CGFloat = 5
    var lineSpace:CGFloat = 5
    var ratioTicket:CGFloat = 1.6329113924
    
    var isSystematic = false
    var numberSystematic = 6 {
        didSet{
            if numberSystematic > systematicData.normal.count {
                systematicData.isFull = false
            } else {
                for _ in 0..<(systematicData.normal.count - numberSystematic) {
                    systematicData.normal.removeLast()
                }
                systematicData.isFull = true
            }
            collectionView.reloadData()
        }
    }
    
    var data:[TicketModel] = []
    var systematicData:TicketModel = TicketModel()
    
    //192 × 278
    lazy var sizeCell:CGSize = CGSize.init(width: (self.view.frame.width - cellSpace *  CGFloat(maxCol) - 1) / (CGFloat(maxCol)), height: (self.view.frame.width - cellSpace *  CGFloat(maxCol) - 1) / (CGFloat(maxCol)) * ratioTicket)
    
    init() {
        super.init(nibName: "TicketViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = KTCenterFlowLayout()
        layout.minimumInteritemSpacing = cellSpace
        layout.minimumLineSpacing = lineSpace
        
        collectionView.backgroundColor = nil
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        collectionView.register(UINib.init(nibName: cellId, bundle: nil), forCellWithReuseIdentifier: cellId)
        collectionView.register(UINib.init(nibName: systematicCellId, bundle: nil), forCellWithReuseIdentifier: systematicCellId)
    }
    
    func startRandom(){
        if isSystematic {
            systematicData = RandomTicket().randSystematicTicket(numberSystematic: numberSystematic, rule: ticketRule)
            return
        }
        
        data = RandomTicket().randListTickets(number: data.count, rule: ticketRule)
    }
    
    func startAnime(){
        if isSystematic {
            let cell = collectionView.cellForItem(at: IndexPath.init(row: 0, section: 0)) as! SystematicCollectionViewCell
            cell.startAnime()
        } else {
            for i in 0..<numberTicket {
                let cell = collectionView.cellForItem(at: IndexPath.init(row: i, section: 0)) as! TicketCollectionViewCell
                cell.startAnime()
            } 
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSystematic {
            return 1
        }
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isSystematic {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: systematicCellId, for: indexPath) as! SystematicCollectionViewCell
            cell.numberLbl.text = "Systematic \(numberSystematic)"
            cell.data = systematicData
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TicketCollectionViewCell
        cell.numberLbl.text = "\(indexPath.item + 1)"
        cell.data = data[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isSystematic {
            
        }
        print("select ticket:\(indexPath.item)")
        let handPickVC = HandPickNumberTicketViewController.init(index: indexPath.item, ticketVC: self)
        self.present(handPickVC, animated: true, completion: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isSystematic {
            // 528 × 136
            return CGSize.init(width: sizeCell.height / 2 * 2.96335078534, height: sizeCell.height / 2)
        }
        //192 × 278
        return sizeCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if maxCol < numberTicket && numberTicket < maxCol * 2{
            let firstRow = numberTicket / 2 + numberTicket % 2
            return UIEdgeInsetsMake(0, sizeCell.width / 2 * CGFloat(maxCol - firstRow), 0, 0)
        }
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }

}
