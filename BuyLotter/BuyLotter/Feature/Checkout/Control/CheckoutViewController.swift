//
//  CheckoutViewController.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/10/12.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController {
    
    weak var ticketVC:TicketViewController!
    
    var data:[TicketModel] = []
    var systematicData:TicketModel = TicketModel()
    var isSystematic = false
    var numberSystematic = 6
    var price:Double = 2000
    
    var ltrB:Double = 0
    var ethB:Double = 0
    
    var dataBuy:[TicketModel] = []
    
    @IBOutlet weak var logoImg: UIImageView!
    
    @IBOutlet weak var valueJackpotLbl: UILabel!
    
    @IBOutlet weak var timeDrawLbl: UILabel!
    
    @IBOutlet weak var ltrTitleLbl: UILabel!
    @IBOutlet weak var ltrValueLbl: UILabel!
    
    @IBOutlet weak var ethTitleLbl: UILabel!
    @IBOutlet weak var ethValueLbl: UILabel!
    
    @IBOutlet weak var detailValueTicketLbl: UILabel!
    
    @IBOutlet weak var totalTitleLbl: UILabel!
    @IBOutlet weak var totalValueTicketLbl: UILabel!
    
    @IBOutlet weak var ticketPriceExplainLbl: UILabel!
    
    @IBOutlet weak var quitImg: UIImageView!
    
    @IBOutlet weak var pwdTxt: UITextField!
    
    @IBOutlet weak var notifyPwdLbl: UILabel!
    
    @IBOutlet weak var checkoutBtn: UIButton!
    
    init(ticketVC:TicketViewController) {
        self.ticketVC = ticketVC
        self.data = ticketVC.data
        self.isSystematic = ticketVC.isSystematic
        self.systematicData = ticketVC.systematicData
        self.numberSystematic = ticketVC.numberSystematic
        
        super.init(nibName: "CheckoutViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDismissKeyboard()
        // Do any additional setup after loading the view.
        notifyPwdLbl.isHidden = true
        quitImg.image = UIImage(named: "quit-icon")?.withRenderingMode(.alwaysTemplate)
        quitImg.tintColor = .white
        
        if !isSystematic {
            for ticket in data {
                if ticket.isFull {
                    dataBuy.append(ticket)
                }
            }
        }
        
        if let username = UserDefaults.standard.string(forKey: "user-email"), let pwd = UserDefaults.standard.string(forKey: "user-pwd") {
            AccountService().getBalance(username: username, pwd: pwd) { [weak self] (done, msg, data) in
                if done {
                    if let ethB = data!["ETHBalance"] as? Double, let ltrB = data!["LTRBalance"] as? Double {
                        self?.ltrB = ltrB
                        self?.ethB = ethB
                        
                        
                        self?.ltrValueLbl.text = ltrB.toStringFormat()
                        self?.ethValueLbl.text = ethB.toStringFormat()
                    }
                }
            }
        }

        ticketPriceExplainLbl.text = "\("Ticket price".localized(using: "LabelTitle")) (\(dataBuy.count) x 2000 LTR)"
        detailValueTicketLbl.text = "\(Double(dataBuy.count) * price) LTR"
        totalValueTicketLbl.text = "\(Double(dataBuy.count) * price) LTR"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUIFollowLanguage()
    }
    
    func updateUIFollowLanguage(){
        pwdTxt.placeholder = "Password".localized(using: "LabelTitle")
        timeDrawLbl.text = "Draw close in".localized(using: "LabelTitle") + " 03:08:23"
        ltrTitleLbl.text = "LTR Balance".localized(using: "LabelTitle")
        ethTitleLbl.text = "ETH Balance".localized(using: "LabelTitle")
        totalTitleLbl.text = "Total".localized(using: "LabelTitle")
        checkoutBtn.setTitle("CHECKOUT".localized(using: "ButtonTitle"), for: .normal)
        notifyPwdLbl.text = "Please enter correct your password to checkout".localized(using: "LabelTitle")
        
        checkoutBtn.isUserInteractionEnabled = true
        checkoutBtn.setTitle("CHECKOUT".localized(using: "ButtonTitle"), for: .normal)
        checkoutBtn.backgroundColor = UIColor.orange
    }
    

    @IBAction func quitBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func checkoutBtnTapped(_ sender: Any) {
        print("start checkout")
        if pwdTxt.text == nil || pwdTxt.text == "" {
            notifyPwdLbl.isHidden = false
            return
        }
        if ltrB < Double(dataBuy.count) * price {
            self.alertOk(title: "Not enough LTR".localized(using: "LabelTitle"), message: "You need more LTR to buy ticket.".localized(using: "LabelTitle")) {
                
            }
            return
        }
        
        checkoutBtn.isUserInteractionEnabled = false
        checkoutBtn.setTitle("PROCESSING".localized(using: "ButtonTitle"), for: .normal)
        checkoutBtn.backgroundColor = UIColor.lightGray
        
        if let email = UserDefaults.standard.string(forKey: "user-email") {
            CheckoutService.init().checkout(email: email, pwd: pwdTxt.text!, ticketsData: dataBuy) { [weak self](done,msg, txhash) in
                
                if done {
                    let popup = CheckoutPopupViewController.init(txhash: txhash)
                    self?.add(popup, anime: .None)
                } else {
                    // failt
                    let popup = CheckoutFailtPopupViewController.init(msg, false)
                    self?.add(popup, anime: .None)
                }
            }
        }
    }
    

}
