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
    
    var dataBuy:[TicketModel] = []
    
    @IBOutlet weak var logoImg: UIImageView!
    
    @IBOutlet weak var valueJackpotLbl: UILabel!
    
    @IBOutlet weak var timeDrawLbl: UILabel!
    
    @IBOutlet weak var ltrValueLbl: UILabel!
    
    @IBOutlet weak var ethValueLbl: UILabel!
    
    @IBOutlet weak var detailValueTicketLbl: UILabel!
    
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
                        self?.ltrValueLbl.text = "\(Double(Int(ltrB * 1000000)) / 1000000)"
                        self?.ethValueLbl.text = "\(Double(Int(ethB * 1000000)) / 1000000)"
                    }
                }
            }
        }

        ticketPriceExplainLbl.text = "Ticket price (\(dataBuy.count) x 2000 LTR)"
        detailValueTicketLbl.text = "\(dataBuy.count * 2000) LTR"
        totalValueTicketLbl.text = "\(dataBuy.count * 2000) LTR"
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
        
        checkoutBtn.showLoadingRight(style: .white)
        
        if let email = UserDefaults.standard.string(forKey: "user-email") {
            CheckoutService.init().checkout(email: email, pwd: pwdTxt.text!, ticketsData: dataBuy) { [weak self](done,msg, txhash) in
                self?.checkoutBtn.hideLoading()
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
