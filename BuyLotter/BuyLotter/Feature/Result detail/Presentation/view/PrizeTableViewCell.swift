//
//  PrizeTableViewCell.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/10/5.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit

class PrizeTableViewCell: UITableViewCell {
    @IBOutlet weak var noLbl: UILabel!
    @IBOutlet weak var matchLbl: UILabel!
    
    @IBOutlet weak var payoutLbl: UILabel!
    @IBOutlet weak var underView: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
