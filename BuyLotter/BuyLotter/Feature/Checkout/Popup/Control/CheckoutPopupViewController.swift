//
//  CheckoutPopupViewController.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/10/15.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit

class CheckoutPopupViewController: UIViewController {
    
    
    @IBOutlet weak var txhashLbl: UILabel!
    
    var txhash = ""
    
    init(txhash:String) {
        self.txhash = txhash
        super.init(nibName: "CheckoutPopupViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txhashLbl.text = "\(txhash)"
        
    }

    @IBAction func viewBtnTapped(_ sender: Any) {
        print("view transaction")
        let webview = TransactionViewController.init(txhash: txhash)
        self.present(webview, animated: true, completion: nil)
    }
    
    @IBAction func quitBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
