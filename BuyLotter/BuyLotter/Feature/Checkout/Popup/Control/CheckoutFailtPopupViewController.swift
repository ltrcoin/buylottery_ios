//
//  CheckoutFailtPopupViewController.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/10/15.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit

class CheckoutFailtPopupViewController: UIViewController {
    
    @IBOutlet weak var popUpAreaView: UIView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var buyMoreBtn: UIButton!
    
    var msg = ""
    var isNotEnough = true
    init(_ msg:String, _ isNotEnough:Bool = false) {
        self.msg = msg
        self.isNotEnough = isNotEnough
        super.init(nibName: "CheckoutFailtPopupViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentLbl.text = msg
        if !isNotEnough {
            buyMoreBtn.setTitle("Cancel", for: .normal)
        }
        popUpAreaView.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUIFollowLanguage()
    }

    func updateUIFollowLanguage(){
        titleLbl.text = "FAIL".localized(using: "LabelTitle")
        contentLbl.text = "Not enough LTR".localized(using: "LabelTitle")
        buyMoreBtn.setTitle("Buy more LTR".localized(using: "ButtonTitle"), for: .normal)
    }

    @IBAction func quitBtnTapped(_ sender: Any) {
        self.removeSelf()
    }
    
    @IBAction func buyMoreBtnTapped(_ sender: Any) {
        print("buy more coin tapped")
        MenuSideViewController.Instance.buyLTRTokenBtnTapped(self)
        if !isNotEnough {
            self.removeSelf()
        } else {
            
        }
    }
    
}
