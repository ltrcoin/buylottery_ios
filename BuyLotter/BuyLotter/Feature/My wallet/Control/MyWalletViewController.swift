//
//  MyWalletViewController.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/10/18.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit

class MyWalletViewController: UIViewController {
    var menuSide:MenuSideInterface!
    
    @IBOutlet weak var copiedLbl: UILabel!
    @IBOutlet weak var menuImg: UIImageView!
    
    @IBOutlet weak var walletAddressTv: UITextView!
    
    @IBOutlet weak var ltrTxt: UITextField!
    
    @IBOutlet weak var ethTxt: UITextField!
    
    init() {
        super.init(nibName: "MyWalletViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuImg.image = UIImage.init(named: "menu")?.withRenderingMode(.alwaysTemplate)
        menuImg.tintColor = .white
        walletAddressTv.layer.cornerRadius = 5
        walletAddressTv.layer.borderWidth = 1
        walletAddressTv.layer.borderColor = UIColor.init(red: 231/255, green: 231/255, blue: 231/255, alpha: 1).cgColor
        copiedLbl.layer.cornerRadius = 5
    }
    
    override func viewDidAppear(_ animated: Bool) {
        menuSide.updateBalance()
    }

    func updateLTR(addr:String, ltr:Double, eth:Double){
        walletAddressTv.text = addr
//        return String(format:"%01i days %02i:%02i:%02i", day, hours, minutes, seconds)
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.allowsFloats = true
        numberFormatter.maximumFractionDigits = 6
        ltrTxt.text = numberFormatter.string(from: NSNumber.init(value: ltr))
        ethTxt.text = numberFormatter.string(from: NSNumber.init(value: eth))
    }
    
    @IBAction func menuSideBtnTapped(_ sender: Any) {
        menuSide.toggleMenuSide()
    }
    
    @IBAction func copiedBtnTapped(_ sender: Any) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = walletAddressTv.text
        self.copiedLbl.alpha = 1
        UIView.animate(withDuration: 1) {
            self.copiedLbl.alpha = 0
        }
    }
    
}
