//
//  CheckoutFailtPopupViewController.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/10/15.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit

class CheckoutFailtPopupViewController: UIViewController {
    
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var buyMoreBtn: UIButton!
    
    var msg = ""
    var isNotEnough = true
    init(_ msg:String, _ isNotEnough:Bool = false) {
        self.msg = msg
        self.isNotEnough = isNotEnough
        super.init(nibName: "CheckoutFailtPopupViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentLbl.text = msg
        if !isNotEnough {
            buyMoreBtn.setTitle("Cancel", for: .normal)
        }
    }

    

    @IBAction func quitBtnTapped(_ sender: Any) {
        self.removeSelf()
    }
    
    @IBAction func buyMoreBtnTapped(_ sender: Any) {
        print("buy more coin tapped")
        if !isNotEnough {
            self.removeSelf()
        } else {
            
        }
    }
    
}
