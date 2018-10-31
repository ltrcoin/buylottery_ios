//
//  CheckoutPopupViewController.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/10/15.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit

class CheckoutPopupViewController: UIViewController {
    
    @IBOutlet weak var popUpAreaView: UIView!
    
    @IBOutlet weak var txhashLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var transactionLbl: UILabel!
    @IBOutlet weak var viewLbl: UILabel!
    
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
        popUpAreaView.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUIFollowLanguage()
    }
    func updateUIFollowLanguage() {
        titleLbl.text = "SUCCESS".localized(using: "LabelTitle")
        transactionLbl.text = "Transaction:".localized(using: "LabelTitle")
        viewLbl.text = "View".localized(using: "LabelTitle")
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
