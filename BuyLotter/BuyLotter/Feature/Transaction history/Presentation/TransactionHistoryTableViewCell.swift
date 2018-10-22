//
//  TransactionHistoryTableViewCell.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/10/18.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit

class TransactionHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet var listNumberViews: [NumberCircleView]!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var txHashLbl: UILabel!
    
    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var priceLbl: UILabel!
    
    var data:TransactionHistoryModel! {
        didSet{
            let count = listNumberViews.count
            for i in (0..<count).reversed() {
                if i >= count - data.specials.count {
                    listNumberViews[i].setupSpecial(data.specials[data.specials.count - (count - i - 1) - 1])
                } else if i >= count - data.specials.count - data.normals.count {
                    listNumberViews[i].setupNormal(data.normals[data.normals.count - (count - data.specials.count - i - 1) - 1])
                } else{
                    listNumberViews[i].isHidden = true
                }
            }
            
            timeLbl.text = data.timeStr
            txHashLbl.text = "TxHash: \(data.txHash)"
            if data.gameId == 3 {
                titleLbl.text = "LTR jackpot"
            }
            priceLbl.text = "Price: \(data.price) LTR"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
