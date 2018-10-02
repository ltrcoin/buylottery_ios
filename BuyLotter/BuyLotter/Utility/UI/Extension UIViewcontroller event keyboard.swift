//
//  Extension UIViewcontroller event keyboard.swift
//  CNCAPP
//
//  Created by HieuTT on 09/07/2018.
//  Copyright © 2018 CNCVN. All rights reserved.
//

import UIKit

extension UIViewController {

    func addKeyboardEvent(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func removeKeyboardEvent(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue {
            print("\(keyboardFrame.height)")
            keyboardWillShow(heightKeyboard: keyboardFrame.height)
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        print("key board hide")
        self.view.frame.origin.y = 0
    }

    @objc func keyboardWillShow(heightKeyboard:CGFloat){

    }
}
