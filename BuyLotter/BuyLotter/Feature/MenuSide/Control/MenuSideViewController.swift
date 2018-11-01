//
//  MenuSideViewController.swift
//  MenuSide
//
//  Created by admin on 2018/9/5.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit
import Localize_Swift

@objc
protocol MenuSideInterface {
    func showMenuSide()
    func hideMenuSide()
    func toggleMenuSide()
    
    func updateBalance()
    
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
    
    @IBOutlet weak var homeLbl: UILabel!
    @IBOutlet weak var resultLbl: UILabel!
    @IBOutlet weak var transactionLbl: UILabel!
    @IBOutlet weak var buyLTRLbl: UILabel!
    @IBOutlet weak var languageLbl: UILabel!
    @IBOutlet weak var signInLbl: UILabel!
    @IBOutlet weak var signUpLbl: UILabel!
    
    @IBOutlet weak var myWalletLbl: UILabel!
    @IBOutlet weak var buyLTRSubLbl: UILabel!
    @IBOutlet weak var profileLbl: UILabel!
    @IBOutlet weak var verify2FALbl: UILabel!
    @IBOutlet weak var signOutLbl: UILabel!
    
    @IBOutlet weak var signUpView: UIView!
    @IBOutlet weak var leftCT: NSLayoutConstraint!
    
    @IBOutlet weak var contentAreaView: UIView!
    @IBOutlet weak var ltrLbl: UILabel!
    @IBOutlet weak var ethLbl: UILabel!
    
    @IBOutlet weak var showContentBtn: UIButton!
    
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
    var buyLtrVC:BuyLTRCoinViewController!
    var profileVC:ProfileViewController!
    
    var rectContent = CGRect.zero
    
    init() {
        super.init(nibName: "MenuSideViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        showContentBtn.isUserInteractionEnabled = false
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
        buyLtrVC = BuyLTRCoinViewController.init()
        profileVC = ProfileViewController.init()
        
        
        homeVC.menuSide = self
        signInVC.menuSide = self
        resultVC.menuSide = self
        transactionVC.menuSide = self
        myWalletVC.menuSide = self
        buyLtrVC.menuSide = self
        profileVC.menuSide = self
        
        rectContent = CGRect.init(x: 0, y: 0, width: contentAreaView.frame.width, height: contentAreaView.frame.height)
        
        self.add(resultVC, anime: .None, rect: rectContent, parentView: contentAreaView)
        self.add(signInVC, anime: .None, rect: rectContent, parentView: contentAreaView)
        self.add(transactionVC, anime: .None, rect: rectContent, parentView: contentAreaView)
        self.add(myWalletVC, anime: .None, rect: rectContent, parentView: contentAreaView)
        self.add(buyLtrVC, anime: .None, rect: rectContent, parentView: contentAreaView)
        self.add(profileVC, anime: .None, rect: rectContent, parentView: contentAreaView)
        
        self.add(homeVC, anime: .None, rect: rectContent, parentView: contentAreaView)
        targetVC = homeVC
        
        
        if let username = UserDefaults.standard.string(forKey: "user-email"), let pwd = UserDefaults.standard.string(forKey: "user-pwd") {
            signInVC.login(email: username, pwd: pwd)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUIFollowLanguage()
    }
    
    func updateUIFollowLanguage() {
        homeLbl.text = "HOME".localized(using: "LabelTitle")
        resultLbl.text = "LOTTERY RESULTS".localized(using: "LabelTitle")
        transactionLbl.text = "TRANSACTION".localized(using: "LabelTitle")
        buyLTRLbl.text = "BUY LTR TOKEN".localized(using: "LabelTitle")
        buyLTRSubLbl.text = "Buy LTR token".localized(using: "LabelTitle")
        languageLbl.text = "LANGUAGE".localized(using: "LabelTitle")
        myWalletLbl.text = "My wallet".localized(using: "LabelTitle")
        profileLbl.text = "Profile".localized(using: "LabelTitle")
        signOutLbl.text = "Sign out".localized(using: "LabelTitle")
        verify2FALbl.text = "2FA Verification".localized(using: "LabelTitle")
        signUpLbl.text = "SIGN UP".localized(using: "LabelTitle")
        
        if isLogin {
            signInLbl.text = "MY ACCOUNT".localized(using: "LabelTitle")
        } else {
            signInLbl.text = "SIGN IN".localized(using: "LabelTitle")
        }
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
        showContentBtn.isUserInteractionEnabled = true
        isShowMenuSide = true
        self.leftCT.constant = spaceExpandValue
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    func hideMenuSide() {
        showContentBtn.isUserInteractionEnabled = false
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
        buyLtrVC.updateLTR(addr: addr, ltr: ltr, eth: eth)
    }
    
    func logined(data: Dictionary<String, Any>) {
        USER_DATA = data
        profileVC.updateViewWithData()
        updateUILogin()
        
        self.add(targetVC, anime: .None, rect: rectContent, parentView: contentAreaView)
        targetVC.viewWillAppear(true)
        hideMenuSide()
    }
    
    func updateUILogin(){
        isLogin = true
        signUpView.isHidden = true
        signInLbl.text = "MY ACCOUNT".localized(using: "LabelTitle")
        
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
    
    @IBAction func languageBtnTapped(_ sender: Any) {
        let langVC = LanguageViewController.init()
        self.present(langVC, animated: true, completion: nil)
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
        
        
        let registerVC = UIStoryboard.init(name: "Register", bundle: nil).instantiateViewController(withIdentifier: "RegisterNav")
        
        self.present(registerVC, animated: true) {
            self.add(self.signInVC, anime: .None, rect: self.rectContent, parentView: self.contentAreaView)
            self.hideMenuSide()
        }
    }
    
    @IBAction func myWalletBtnTapped(_ sender: Any) {
        print("myWalletBtnTapped")
        self.add(myWalletVC, anime: .None, rect: rectContent, parentView: contentAreaView)
        myWalletVC.viewDidAppear(true)
        hideMenuSide()
    }
    
    
    @IBAction func buyLTRTokenBtnTapped(_ sender: Any) {
        print("buyLTRTockenBtnTapped")

        if isLogin {
            self.add(buyLtrVC, anime: .None, rect: rectContent, parentView: contentAreaView)
            buyLtrVC.viewDidAppear(true)
        } else {
            targetVC = buyLtrVC
            self.add(signInVC, anime: .None, rect: rectContent, parentView: contentAreaView)
        }
        hideMenuSide()
    }
    
    @IBAction func profileBtnTapped(_ sender: Any) {
        print("profileBtnTapped")
        self.add(profileVC, anime: .None, rect: rectContent, parentView: contentAreaView)
        hideMenuSide()
    }
    
    @IBAction func twoFABtnTapped(_ sender: Any) {
        print("twoFABtnTapped")
    }
    
    
    @IBAction func signOutBtnTapped(_ sender: Any) {
        print("signOutBtnTapped")
        UserDefaults.standard.removeObject(forKey: "user-pwd")
        UserDefaults.standard.removeObject(forKey: "user-email")
        USER_DATA = nil
        isLogin = false
        signInLbl.text = "SIGN IN".localized(using: "LabelTitle")
        signUpView.isHidden = false
        
        ltrCoin = 0
        ethCoin = 0
        
        ltrLbl.text = "LTR: 0"
        ethLbl.text = "ETH: 0"
        
        isExpand = false
        heighSubViewCT.constant = 0
        self.view.layoutIfNeeded()
        targetVC = homeVC
        self.add(signInVC, anime: .None, rect: rectContent, parentView: contentAreaView)
        hideMenuSide()
    }
}
