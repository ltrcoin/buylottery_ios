//
//  GuideSystematicViewController.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/9/26.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit

class GuideSystematicViewController: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var defineLbl: UILabel!
    @IBOutlet weak var contentDefineLbl: UITextView!
    
    @IBOutlet weak var guidLbl: UILabel!
    
    @IBOutlet weak var guidContentLbl: UITextView!
    
    init(){
        super.init(nibName: "GuideSystematicViewController", bundle: nil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        titleLbl.text = "Systematic Forms".localized(using: "LabelTitle")
        
        defineLbl.text = "What is a Systematic Form?".localized(using: "LabelTitle")
        
        contentDefineLbl.text = "A systematic form takes your selected numbers and creates every unique combination possible, increasing your chances of hitting the jackpot!".localized(using: "LabelTitle")
        
        guidLbl.text = "Why Play a Systematic Form?".localized(using: "LabelTitle")
        
        guidContentLbl.text = "A systematic form increase your odds of winning the jackpot and also the total of wins! Any winning comvination will appear multiple times in the combinations generated for you, upping your total win amount!".localized(using: "LabelTitle")
    }

    @IBAction func quitBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
