//
//  TwoFactorAuthenViewController.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/9/20.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit

class TwoFactorAuthenViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var inputAreaView: UIView!
    
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var heightErrorViewCT: NSLayoutConstraint!
    
    @IBOutlet weak var codeTxt: UITextField!
    
    @IBOutlet weak var spaceBottomCT: NSLayoutConstraint!
    
    @IBOutlet weak var authenticateBtn: UIButton!
    var oldConstraint:CGFloat = 0
    var testCount = 0
    init() {
        super.init(nibName: "TwoFactorAuthenViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implement this code")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addKeyboardEvent()
        oldConstraint = spaceBottomCT.constant
        setDismissKeyboard()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeKeyboardEvent()
    }
    
    func setupView(){
        inputAreaView.layer.borderWidth = 1
        inputAreaView.layer.cornerRadius = 8
        inputAreaView.layer.borderColor =  UIColor.init(red: 158/255, green: 175/255, blue: 174/255, alpha: 1).cgColor
        
        errorView.layer.cornerRadius = 4
        authenticateBtn.layer.cornerRadius = 5
        
    }

    
    @IBAction func backBtnTapped(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func authenticateBtnTapped(_ sender: Any) {
        if testCount >= 1 {
            let homeVC = HomeViewController.init()
            self.present(homeVC, animated: true, completion: nil)
        }
        testCount += 1
        heightErrorViewCT.constant = 29
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    override func keyboardWillShow(heightKeyboard: CGFloat) {
        spaceBottomCT.constant = heightKeyboard + 5
        let frame = codeTxt?.superview?.convert((codeTxt?.frame)!, to: self.view)
        let yFocusView = (frame?.maxY)!
        let heightScreen = view.frame.height
        print("\(yFocusView)")
        print("\(heightScreen - heightKeyboard)")
        if yFocusView > heightScreen - heightKeyboard - 70 {
            UIView.animate(withDuration: 0.2) {
                self.scrollView.contentOffset.y += (yFocusView - (heightScreen - heightKeyboard - 70))
            }
        }
        print("\(scrollView.contentOffset)")
    }
    
    override func keyboardWillHide(notification: NSNotification) {
        spaceBottomCT.constant = oldConstraint
    }

}
