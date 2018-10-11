//
//  NumberCircleView.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/10/4.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit

class NumberCircleView: UIView {

    @IBOutlet weak var circleImg: UIImageView!
    
    @IBOutlet weak var numberLbl: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    @IBOutlet var view: UIView!
    
    func loadNibView() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    
    func xibSetup() {
        backgroundColor = UIColor.clear
        view = loadNibView()
        // use bounds not frame or it'll be offset
        view.frame = bounds
        //        // Adding custom subview on top of our view
        addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": view]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": view]))
    }
    
    func setupNormal(_ number:Int) {
        circleImg.image = UIImage.init(named: "normal-circle-icon")
        numberLbl.text = String.init(format: "%01i", number)
    }
    
    func setupSpecial(_ number:Int) {
        circleImg.image = UIImage.init(named: "special-circle-icon")
        numberLbl.text = String.init(format: "%01i", number)
    }
}
