//
//  Extension UIView add tap gesture.swift
//  CNCAPP
//
//  Created by Satacus on 06/07/2018.
//  Copyright © 2018 CNCVN. All rights reserved.
//

import UIKit
extension UIViewController {
    func setTapGesture(view: UIView, action: Selector?) {
        let tap = UITapGestureRecognizer(target: self, action: action)
        view.addGestureRecognizer(tap)
    }
}
