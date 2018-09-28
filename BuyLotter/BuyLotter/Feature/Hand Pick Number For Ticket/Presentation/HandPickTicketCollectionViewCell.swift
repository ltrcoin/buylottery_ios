//
//  HandPickTicketCollectionViewCell.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/9/26.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit

class HandPickTicketCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var numberLbl: UILabel!
    
    var isChoose = false
    
    var colorNormalChoose = UIColor.init(red: 31/255, green: 66/255, blue: 135/255, alpha: 1)
    var colorSpecialChoose = UIColor.init(red: 215/255, green: 78/255, blue: 38/255, alpha: 1)
    var colorSpecialNotChoose = UIColor.init(red: 240/255, green: 133/255, blue: 77/255, alpha: 1)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func toggleNormal(){
        isChoose = !isChoose
        updateNormal()
    }
    
    func toggleSpecial(){
        isChoose = !isChoose
        updateSpecial()
    }
    
    func updateNormal(){
        if isChoose {
            backgroundColor = colorNormalChoose
            numberLbl.textColor = .white
        } else {
            backgroundColor = .white
            numberLbl.textColor = .black
        }
    }
    
    func updateSpecial(){
        numberLbl.textColor = .white
        if isChoose {
            backgroundColor = colorSpecialChoose
        } else {
            backgroundColor = colorSpecialNotChoose
        }
    }
}

