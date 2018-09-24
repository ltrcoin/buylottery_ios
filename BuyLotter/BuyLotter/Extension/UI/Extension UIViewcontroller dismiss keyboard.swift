//
//  Extension UIViewcontroller dismiss keyboard.swift
//  CNCAPP
//
//  Created by Satacus on 07/07/2018.
//  Copyright © 2018 CNCVN. All rights reserved.
//

import UIKit
extension UIViewController {
    func setDismissKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}
