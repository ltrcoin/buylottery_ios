//
//  Extention EducationMySchoolLogin event textfield.swift
//  CNCAPP
//
//  Created by Satacus on 07/07/2018.
//  Copyright © 2018 CNCVN. All rights reserved.
//

import UIKit
extension LoginViewController: UITextFieldDelegate {

    func setupTxtDelegate(){
        accountTxt.delegate = self
        pwdTxt.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == accountTxt {
            pwdTxt.becomeFirstResponder()
            print("switch to pwd field")
        }
        if textField == pwdTxt {
            print("logining")
            loginDidTouch("")
        }
        return true
    }
    
}
