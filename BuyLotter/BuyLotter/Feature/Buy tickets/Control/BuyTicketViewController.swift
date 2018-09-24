//
//  BuyTicketViewController.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/9/24.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit

class BuyTicketViewController: UIViewController {

    @IBOutlet var numberBtns: [UIButton]!
    
    @IBOutlet var systematicNumberBtns: [UIButton]!
    
    @IBOutlet weak var stackSystematicView: UIView!
    @IBOutlet weak var systematicBtn: UIButton!
    
    @IBOutlet weak var psSystematicLbl: UILabel!
    
    @IBOutlet weak var systematicHeightCT: NSLayoutConstraint!
    
    var oldSystematicHeightCT:CGFloat = 0
    var focusColor = UIColor.init(red: 60/255, green: 91/255, blue: 168/255, alpha: 1)
    
    var isSystematic = false
    
    var numberTitles = [3,5,7,10,15,20,25]
    var systematicTitles = [6,7,8,9,10,11]
    var systematicPSData = [6,21,56,126,252,462]
    
    init() {
        super.init(nibName: "BuyTicketViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBtnView()
        view.layoutIfNeeded()
        oldSystematicHeightCT = systematicHeightCT.constant
        systematicHeightCT.constant = 0
        view.layoutIfNeeded()
    }
    
    func setupBtnView(){
        for i in 0..<numberBtns.count {
            if i < numberTitles.count {
                numberBtns[i].layer.borderWidth = 1
                numberBtns[i].layer.cornerRadius = 5
                numberBtns[i].layer.borderColor = focusColor.cgColor
                numberBtns[i].setTitle("\(numberTitles[i])", for: .normal)
            } else {
                numberBtns[i].removeFromSuperview()
            }
            
        }
        
        numberBtns[0].backgroundColor = focusColor
        numberBtns[0].setTitleColor(UIColor.white, for: .normal)
        
        systematicBtn.layer.borderWidth = 1
        systematicBtn.layer.cornerRadius = 5
        systematicBtn.layer.borderColor = focusColor.cgColor
        systematicBtn.backgroundColor = nil
        systematicBtn.setTitleColor(focusColor, for: .normal)
        
        stackSystematicView.layer.borderWidth = 1
        stackSystematicView.layer.cornerRadius = 5
        stackSystematicView.layer.borderColor = focusColor.cgColor
    }
    
    @IBAction func numberBtnTapped(_ sender: Any) {
        if let pressedBtn = sender as? UIButton {
            for i in 0..<numberBtns.count {
                if pressedBtn == numberBtns[i] {
                    print(i)
                    numberBtns[i].backgroundColor = focusColor
                    numberBtns[i].setTitleColor(UIColor.white, for: .normal)
                    
                } else {
                    numberBtns[i].backgroundColor = nil
                    
                    numberBtns[i].setTitleColor(focusColor, for: .normal)
                }
            }
        }
        setHideSystematicNumber()
    }
    
    @IBAction func systematicBtnTapped(_ sender: Any) {

        systematicHeightCT.constant = oldSystematicHeightCT
        systematicBtn.setTitleColor(UIColor.white, for: .normal)
        systematicBtn.backgroundColor = focusColor
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
        resetNumberBtnFocus()
    }
    
    
    @IBAction func numberSystematicTapped(_ sender: Any) {
        if let pressedBtn = sender as? UIButton {
            for i in 0..<systematicNumberBtns.count {
                if pressedBtn == systematicNumberBtns[i] {
                    print(i)
                    systematicNumberBtns[i].backgroundColor = focusColor
                    systematicNumberBtns[i].setTitleColor(UIColor.white, for: .normal)
                    
                    psSystematicLbl.text = "\(systematicTitles[i]) Numbers = \(systematicPSData[i]) Lines"
                } else {
                    systematicNumberBtns[i].backgroundColor = nil
                    
                    systematicNumberBtns[i].setTitleColor(focusColor, for: .normal)
                }
            }
        }
    }
    
    
    func resetNumberBtnFocus(){
        for i in 0..<numberBtns.count {
            numberBtns[i].backgroundColor = nil
            numberBtns[i].setTitleColor(focusColor, for: .normal)
        }
    }
    
    func setHideSystematicNumber(){
        systematicBtn.setTitleColor(focusColor, for: .normal)
        systematicBtn.backgroundColor = nil
        systematicHeightCT.constant = 0
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
   

}
