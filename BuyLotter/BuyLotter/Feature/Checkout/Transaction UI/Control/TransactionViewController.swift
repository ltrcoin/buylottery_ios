//
//  TransactionViewController.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/10/15.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit

class TransactionViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    var txhash = ""
    init(txhash:String) {
        self.txhash = txhash
        super.init(nibName: "TransactionViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.loadRequest(NSURLRequest(url: NSURL(string: "https://ropsten.etherscan.io/tx/\(txhash)")! as URL) as URLRequest)
    }

    @IBAction func backBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
