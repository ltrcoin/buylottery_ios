//
//  ViewYourNumbersTableViewCell.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/9/26.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit

class ViewYourNumbersTableViewCell: UITableViewCell {
    @IBOutlet weak var noLbl: UILabel!
    @IBOutlet weak var normalLbl: UILabel!
    
    @IBOutlet weak var specialLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
