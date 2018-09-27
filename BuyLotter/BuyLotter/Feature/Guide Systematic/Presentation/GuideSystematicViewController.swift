//
//  GuideSystematicViewController.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/9/26.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit

class GuideSystematicViewController: UIViewController {

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

    @IBAction func quitBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
