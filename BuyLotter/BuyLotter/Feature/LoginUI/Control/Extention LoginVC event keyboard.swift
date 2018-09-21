//
//  Extention EducationMySchoolLogin event keyboard.swift
//  CNCAPP
//
//  Created by HieuTT on 07/07/2018.
//  Copyright © 2018 CNCVN. All rights reserved.
//

import UIKit

extension LoginViewController {
    override func keyboardWillShow(heightKeyboard: CGFloat) {
        let frame = loginBtn.superview?.convert(loginBtn.frame, to: view)
        let yFocusView = (frame?.maxY)!
        let heightScreen = view.frame.height
        print("login btn frame:\(frame)")

        if heightKeyboard > (heightScreen - yFocusView) + 10 {
            self.view.frame.origin.y = -(heightKeyboard - (heightScreen - yFocusView) + 10)
        }
    }

}
