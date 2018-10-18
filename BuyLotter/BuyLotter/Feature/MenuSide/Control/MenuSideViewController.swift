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
    
    var homeVC:HomeViewController!
    var signInVC:LoginViewController!
    var resultVC:ResultDetailViewController!
    
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
        
        homeVC = HomeViewController.init(self)
        signInVC = UIStoryboard.init(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        resultVC = ResultDetailViewController.init()
        
        homeVC.menuSide = self
        signInVC.menuSide = self
        resultVC.menuSide = self
        
        rectContent = CGRect.init(x: 0, y: 0, width: contentAreaView.frame.width, height: contentAreaView.frame.height)
        self.add(homeVC, anime: .None, rect: rectContent, parentView: contentAreaView)
        self.add(resultVC, anime: .None, rect: rectContent, parentView: contentAreaView)
        self.add(signInVC, anime: .None, rect: rectContent, parentView: contentAreaView)
        
        self.add(homeVC, anime: .None, rect: rectContent, parentView: contentAreaView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
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
    
    func updateBalance(ltr: Double, eth: Double) {
        ltrCoin = ltr
        ethCoin = eth
        
        ltrLbl.text = "LTR: \(Double(Int(ltr * 1000000)) / 1000000)"
        ethLbl.text = "ETH: \(Double(Int(eth * 1000000)) / 1000000)"
    }
    
    func logined(data: Dictionary<String, Any>) {
        self.add(homeVC, anime: .None, rect: rectContent, parentView: contentAreaView)
        updateUILogin()
    }
    
    func updateUILogin(){
        isLogin = true
        signUpView.isHidden = true
        signInLbl.text = "MY ACCOUNT"
        
        if let username = UserDefaults.standard.string(forKey: "user-email"), let pwd = UserDefaults.standard.string(forKey: "user-pwd") {
            AccountService().getBalance(username: username, pwd: pwd) { [weak self] (done, msg, data) in
                if done {
                    if let ethB = data!["ETHBalance"] as? Double, let ltrB = data!["LTRBalance"] as? Double {
                        self?.updateBalance(ltr: ltrB, eth: ethB)
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
        hideMenuSide()
    }
    
    @IBAction func transactionBtnTapped(_ sender: Any) {
        print("transaction tapped")
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
