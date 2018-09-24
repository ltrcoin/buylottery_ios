//
//  Extension ViewController get view controller.swift
//  SatacusWorld
//
//  Created by Pham Van Tuan on 09/10/2017.
//  Copyright © 2017 Hieu Tran. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
