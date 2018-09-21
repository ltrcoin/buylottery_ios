//
//  RegisterPageOneViewController.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/9/17.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit

class RegisterPageOneViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var inputAreaView: UIView!
    
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var pwdTxt: UITextField!
    
    @IBOutlet weak var re_pwdTxt: UITextField!
    
    @IBOutlet weak var phoneTxt: UITextField!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var spaceBottomCT: NSLayoutConstraint!
    var oldConstraint:CGFloat = 0
    
    var viewFocus:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupDelegate()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addKeyboardEvent()
        oldConstraint = spaceBottomCT.constant
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeKeyboardEvent()
    }
    
    @IBAction func dismissKeyboardTapped(_ sender: Any) {
        self.view.endEditing(true)
    }
    

    @IBAction func nextBtn(_ sender: Any) {
        performSegue(withIdentifier: "next", sender: nil)
    }
    
    @IBAction func quitBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupView(){
        inputAreaView.layer.borderWidth = 1
        inputAreaView.layer.cornerRadius = 8
        inputAreaView.layer.borderColor =  UIColor.init(red: 158/255, green: 175/255, blue: 174/255, alpha: 1).cgColor
        
        nextBtn.layer.cornerRadius = 5
    }
    
    func setupDelegate(){
        emailTxt.delegate = self
        pwdTxt.delegate = self
        re_pwdTxt.delegate = self
        phoneTxt.delegate = self
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("\(textField.frame.maxY)")
        viewFocus = textField
        return true
    }
    
    override func keyboardWillShow(heightKeyboard: CGFloat) {
        spaceBottomCT.constant = heightKeyboard + 5
        if let _ = viewFocus {
            let frame = viewFocus?.superview?.convert((viewFocus?.frame)!, to: self.view)
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
    }
    
    override func keyboardWillHide(notification: NSNotification) {
        spaceBottomCT.constant = oldConstraint
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next"
        {
            if let destinationVC = segue.destination as? RegisterPageTwoViewController {
                destinationVC.model.email = emailTxt.text!
                destinationVC.model.password = pwdTxt.text!
                destinationVC.model.tel = phoneTxt.text!
            }
        }
    }
    
}
