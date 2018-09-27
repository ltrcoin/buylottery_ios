//
//  TicketCollectionViewCell.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/9/25.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit

class TicketCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var numberLbl: UILabel!
    
    @IBOutlet weak var ticketImg: UIImageView!
    var count = 0
    
    var data:TicketModel! {
        didSet{
            if data.isFull {
                setDone()
            } else {
                setEmpty()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setEmpty(){
        self.ticketImg.image = UIImage.init(named: "ticket-symbol")
    }
    
    func setDone(){
        self.ticketImg.image = UIImage.init(named: "ticket-symbol-done")
    }
    
    func startAnime(){
        count = 1
        runAnime()
    }

    func runAnime(){
        let number = Int(arc4random_uniform(3)) + 1
        ticketImg.image = UIImage.init(named: "ticket-symbol-anime\(number)")
        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + 0.1) {
            self.count += 1
            if self.count <= 7 {
                DispatchQueue.main.async {
                    self.runAnime()
                }
            } else {
                DispatchQueue.main.async {
                    self.ticketImg.image = UIImage.init(named: "ticket-symbol-done")
                }
            }
        }
    }
    
}
