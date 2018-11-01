//
//  Extension Double tostring.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/11/1.
//  Copyright © 2018 kazy. All rights reserved.
//

import Foundation
extension Double {
    func toStringFormat()-> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.allowsFloats = true
        numberFormatter.maximumFractionDigits = 6
        numberFormatter.decimalSeparator = "."
        numberFormatter.groupingSeparator = ","
        return numberFormatter.string(from: NSNumber.init(value: self))!
    }
}
