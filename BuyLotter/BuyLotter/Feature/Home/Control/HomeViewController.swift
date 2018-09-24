//
//  HomeViewController.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/9/20.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var playsBtn: [UIButton]!
    
    init() {
        super.init(nibName: "HomeViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlayBtnView()
        
    }

    func setupPlayBtnView(){
        for btn in playsBtn {
            btn.layer.cornerRadius = 5
            btn.layer.masksToBounds = true
        }
    }
    
    @IBAction func playBtnTapped(_ sender: Any) {
        if let pressedBtn = sender as? UIButton {
            for i in 0..<playsBtn.count {
                if pressedBtn == playsBtn[i] {
                    print(i)
                    break
                }
            }
        }
    }
    
}
