//
//  MenuSideViewController.swift
//  MenuSide
//
//  Created by admin on 2018/9/5.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit
@objc
protocol MenuSideInterface {
    func showMenuSide()
    func hideMenuSide()
    func toggleMenuSide()
    @objc optional func updateBalance(ltr:Double, eth:Double)
    
    @objc optional func logined(data:Dictionary<String,Any>)
}

class MenuSideViewController: UIViewController, MenuSideInterface {
    static var Instance:MenuSideViewController!
    
    var walletAddress = ""
    var ltrCoin:Double = 0
    var ethCoin:Double = 0
    var isLogin = false

    @IBOutlet weak var heighSubViewCT: NSLayoutConstraint!
    
    @IBOutlet weak var signInLbl: UILabel!
    @IBOutlet weak var signUpView: UIView!
    @IBOutlet weak var leftCT: NSLayoutConstraint!
    
    @IBOutlet weak var contentAreaView: UIView!
    @IBOutlet weak var ltrLbl: UILabel!
    @IBOutlet weak var ethLbl: UILabel!
    
    
    var spaceExpandValue:CGFloat = 0
    var expandAccountValue:CGFloat = 0
    var isExpand = false
    var isShowMenuSide = false
    
    var targetVC:UIViewController!
    var homeVC:HomeViewController!
    var signInVC:LoginViewController!
    var resultVC:ResultDetailViewController!
    var transactionVC:TransactionHistoryViewController!
    var myWalletVC:MyWalletViewController!
    
    var rectContent = CGRect.zero
    
    init() {
        super.init(nibName: "MenuSideViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MenuSideViewController.Instance = self
        
        self.view.layoutIfNeeded()
        expandAccountValue = heighSubViewCT.constant
        heighSubViewCT.constant = 0
        
        spaceExpandValue = self.view.frame.width * 0.6
        
        // Init vc
        homeVC = HomeViewController.init(self)
        signInVC = UIStoryboard.init(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        resultVC = ResultDetailViewController.init()
        transactionVC = TransactionHistoryViewController.init()
        myWalletVC = MyWalletViewController.init()
        
        homeVC.menuSide = self
        signInVC.menuSide = self
        resultVC.menuSide = self
        transactionVC.menuSide = self
        myWalletVC.menuSide = self
        
        rectContent = CGRect.init(x: 0, y: 0, width: contentAreaView.frame.width, height: contentAreaView.frame.height)
        
        self.add(resultVC, anime: .None, rect: rectContent, parentView: contentAreaView)
        self.add(signInVC, anime: .None, rect: rectContent, parentView: contentAreaView)
        self.add(transactionVC, anime: .None, rect: rectContent, parentView: contentAreaView)
        self.add(myWalletVC, anime: .None, rect: rectContent, parentView: contentAreaView)
        
        self.add(homeVC, anime: .None, rect: rectContent, parentView: contentAreaView)
        targetVC = homeVC
    }
    
    func toggleMenuSide() {
        isShowMenuSide = !isShowMenuSide
        if isShowMenuSide {
            showMenuSide()
        } else {
            hideMenuSide()
        }
    }
    
    func showMenuSide() {
        isShowMenuSide = true
        self.leftCT.constant = spaceExpandValue
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    func hideMenuSide() {
        isShowMenuSide = false
        self.leftCT.constant = 0
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    func updateBalance(addr:String, ltr: Double, eth: Double) {
        walletAddress = addr
        ltrCoin = ltr
        ethCoin = eth
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.allowsFloats = true
        numberFormatter.maximumFractionDigits = 6
        ltrLbl.text = "LTR: \(numberFormatter.string(from: NSNumber.init(value: ltr))!)"
        ethLbl.text = "ETH: \(numberFormatter.string(from: NSNumber.init(value: eth))!)"
        
        myWalletVC.updateLTR(addr:addr, ltr: ltr, eth: eth)
    }
    
    func logined(data: Dictionary<String, Any>) {
        updateUILogin()
        
        self.add(targetVC, anime: .None, rect: rectContent, parentView: contentAreaView)
        hideMenuSide()
    }
    
    func updateUILogin(){
        isLogin = true
        signUpView.isHidden = true
        signInLbl.text = "MY ACCOUNT"
        
        updateBalance()
    }
    
    func updateBalance(){
        if let username = UserDefaults.standard.string(forKey: "user-email"), let pwd = UserDefaults.standard.string(forKey: "user-pwd") {
            AccountService().getBalance(username: username, pwd: pwd) { [weak self] (done, msg, data) in
                if done {
                    if let ethB = data!["ETHBalance"] as? Double, let ltrB = data!["LTRBalance"] as? Double, let address = data!["wallet_address"] as? String {
                        self?.updateBalance(addr:address, ltr: ltrB, eth: ethB)
                    }
                }
            }
        }
    }
    
    @IBAction func quitBtnTapped(_ sender: Any) {
        print("quit tapped")
        hideMenuSide()
    }
    
    @IBAction func homeBtnTapped(_ sender: Any) {
        print("home tapped")
        self.add(homeVC, anime: .None, rect: rectContent, parentView: contentAreaView)
        hideMenuSide()
    }
    
    @IBAction func resultBtnTapped(_ sender: Any) {
        print("result tapped")
        self.add(resultVC, anime: .None, rect: rectContent, parentView: contentAreaView)
        resultVC.viewWillAppear(true)
        hideMenuSide()
    }
    
    @IBAction func transactionBtnTapped(_ sender: Any) {
        print("transaction tapped")
        if isLogin {
            self.add(transactionVC, anime: .None, rect: rectContent, parentView: contentAreaView)
            transactionVC.viewWillAppear(true)
        } else {
            targetVC = transactionVC
            self.add(signInVC, anime: .None, rect: rectContent, parentView: contentAreaView)
        }
        hideMenuSide()
    }
    
    @IBAction func signInBtnTapped(_ sender: Any) {
        print("sign in tapped")
        if !isLogin {
            self.add(signInVC, anime: .None, rect: rectContent, parentView: contentAreaView)
            hideMenuSide()
        } else {
            isExpand = !isExpand
            if isExpand {
                heighSubViewCT.constant = expandAccountValue
            } else {
                heighSubViewCT.constant = 0
            }
            print("\(heighSubViewCT.constant)")
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func signUpBtnTapped(_ sender: Any) {
        print("sign up tapped")
    }
    
    @IBAction func myWalletBtnTapped(_ sender: Any) {
        print("myWalletBtnTapped")
        self.add(myWalletVC, anime: .None, rect: rectContent, parentView: contentAreaView)
        
        hideMenuSide()
    }
    
    
    @IBAction func buyLTRTokenBtnTapped(_ sender: Any) {
        print("buyLTRTockenBtnTapped")
        
    }
    
    @IBAction func profileBtnTapped(_ sender: Any) {
        print("profileBtnTapped")
    }
    
    @IBAction func twoFABtnTapped(_ sender: Any) {
        print("twoFABtnTapped")
    }
    
    
    @IBAction func signOutBtnTapped(_ sender: Any) {
        print("signOutBtnTapped")
        isLogin = false
        signInLbl.text = "SIGN IN"
        signUpView.isHidden = false
        
        isExpand = false
        heighSubViewCT.constant = 0
        self.view.layoutIfNeeded()
    }
}
