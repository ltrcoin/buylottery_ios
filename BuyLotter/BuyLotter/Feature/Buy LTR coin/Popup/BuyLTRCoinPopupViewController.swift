//
//  BuyLTRCoinPopupViewController.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/10/23.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit

class BuyLTRCoinPopupViewController: UIViewController {
    @IBOutlet weak var popUpView: UIView!
    
    @IBOutlet weak var ethTxHashLbl: UILabel!
    
    @IBOutlet weak var ltrTxHashLbl: UILabel!
    
    var ethTx = ""
    var ltrTx = ""
    init(ethTxhash:String, ltrTxhash:String) {
        ethTx = ethTxhash
        ltrTx = ltrTxhash
        super.init(nibName: "BuyLTRCoinPopupViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpView.layer.cornerRadius = 10
    }
    
    @IBAction func quitBtnTapped(_ sender: Any) {
        self.removeSelf()
    }
    
    @IBAction func ethTxHashBtnTapped(_ sender: Any) {
        let webview = TransactionViewController.init(txhash: ethTx)
        self.present(webview, animated: true, completion: nil)
    }
    
    @IBAction func ltrTxHashBtnTapped(_ sender: Any) {
        let webview = TransactionViewController.init(txhash: ltrTx)
        self.present(webview, animated: true, completion: nil)
    }
    
}
