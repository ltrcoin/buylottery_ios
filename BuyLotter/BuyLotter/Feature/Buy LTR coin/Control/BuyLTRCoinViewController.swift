//
//  BuyLTRCoinViewController.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/10/22.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit

class BuyLTRCoinViewController: UIViewController, UITextFieldDelegate {
    var menuSide:MenuSideInterface!
    
    var ratio:Double = 205714.69
    var eth:Double = 0
    var ltr:Double = 0
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var buyBtn: UIButton!
    
    @IBOutlet weak var menuImg: UIImageView!
    
    @IBOutlet weak var bottomCT: NSLayoutConstraint!
    
    @IBOutlet weak var walletAddressTv: UITextView!
    
    @IBOutlet weak var ltrTxt: UITextField!
    
    @IBOutlet weak var ethTxt: UITextField!
    
    @IBOutlet weak var ratioTxt: UITextField!
    
    @IBOutlet weak var ethExchangeTxt: UITextField!
    
    @IBOutlet weak var titleLTRExchangeLbl: UILabel!
    @IBOutlet weak var ltrExchangeTxt: UITextField!
    
    @IBOutlet weak var copiedLbl: UILabel!
    

    
    init() {
        super.init(nibName: "BuyLTRCoinViewController", bundle: nil)
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
        buyBtn.layer.cornerRadius = 5
    
        setDismissKeyboard()
        
        ltrExchangeTxt.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addKeyboardEvent()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeKeyboardEvent()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        BuyLTRCoinService.init().getRatio {[weak self] (value) in
            print("🤬 update new ratio")
            self?.ratio = value * 1000
            self?.updateRatio(value * 1000)
        }
        self.buyBtn.isUserInteractionEnabled = true
        self.buyBtn.backgroundColor = UIColor.orange
        buyBtn.setTitle("Buy Now", for: .normal)
        self.ltrExchangeTxt.text = "0"
        self.ethExchangeTxt.text = "0"
        menuSide.updateBalance()
    }
    
    func updateRatio(_ value:Double){
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.allowsFloats = true
        numberFormatter.maximumFractionDigits = 6
        ratioTxt.text = numberFormatter.string(from: NSNumber.init(value: value))
    }
    
    func updateLTR(addr:String, ltr:Double, eth:Double){
        walletAddressTv.text = addr
        self.eth = eth
        self.ltr = ltr
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.allowsFloats = true
        numberFormatter.maximumFractionDigits = 6
        ltrTxt.text = numberFormatter.string(from: NSNumber.init(value: ltr))
        ethTxt.text = numberFormatter.string(from: NSNumber.init(value: eth))
        
        titleLTRExchangeLbl.text = "Enter the number of LTR to buy by exchange ETH in your account. You can buy maximum \(numberFormatter.string(from: NSNumber.init(value: eth * ratio))!) LTR with your current ETH balance"
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
    
    
    override func keyboardWillShow(heightKeyboard: CGFloat) {
        bottomCT.constant = heightKeyboard

        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
            self.scrollView.contentOffset.y = self.scrollView.contentSize.height - (self.scrollView.bounds.size.height)
        }) { (done) in
            
        }
    }
    
    override func keyboardWillHide(notification: NSNotification) {
        bottomCT.constant = 0
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text, let textRange = Range(range, in: text) {
            
            let valueStr = text.replacingCharacters(in:textRange,with:string)
            
            if let value = Double(valueStr) {
                
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                numberFormatter.allowsFloats = true
                numberFormatter.maximumFractionDigits = 6
                ethExchangeTxt.text = numberFormatter.string(from: NSNumber.init(value: (value / ratio)))
                if value > eth * ratio {
                    ethExchangeTxt.textColor = .red
                } else {
                    ethExchangeTxt.textColor = .black
                }
            }
        }
        
        return true
        
    }
    
    
    @IBAction func buyBtnTapped(_ sender: Any) {
        
        if let value = Double(ltrExchangeTxt.text!), value > eth * ratio  {
            self.alertOk(title: "Not Enough ETH", message: "You need more ETH to buy LTR.") {
                
            }
            return
        }
        
        buyBtn.isUserInteractionEnabled = false
        buyBtn.backgroundColor = UIColor.lightGray
        buyBtn.setTitle("Buying", for: .normal)
        
        if let email = UserDefaults.standard.string(forKey: "user-email"), let pwd = UserDefaults.standard.string(forKey: "user-pwd") {
            BuyLTRCoinService.init().buyLTR(username: email, pwd: pwd, ltr: ltrExchangeTxt.text!) { [weak self] (done, ethTxhash, ltrTxhash) in
                
                self?.buyBtn.isUserInteractionEnabled = true
                self?.buyBtn.hideLoading()
                
                if done {
                    let popup = BuyLTRCoinPopupViewController.init(ethTxhash: ethTxhash, ltrTxhash: ltrTxhash)
                    self?.add(popup, anime: .None)
                } else {
                    
                }
                
            }
        }
        
    }
    
}
