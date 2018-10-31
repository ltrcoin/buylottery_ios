//
//  LanguageViewController.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/10/31.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit
import Localize_Swift

class LanguageViewController: UIViewController {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var englishSelectedLbl: UILabel!
    
    @IBOutlet weak var vnSelectedLbl: UILabel!
    
    @IBOutlet weak var quitImg: UIImageView!
    
    init() {
        super.init(nibName: "LanguageViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLbl.text = "LANGUAGE".localized(using: "LabelTitle")
        quitImg.image = UIImage.init(named: "x-icon")?.withRenderingMode(.alwaysTemplate)
        
        quitImg.tintColor = .white
        
        print("😬 \(Localize.currentLanguage())")
        
        if Localize.currentLanguage() == "en" {
            englishSelectedLbl.text = "selected".localized(using: "LabelTitle")
            vnSelectedLbl.text = ""
        } else {
            vnSelectedLbl.text = "selected".localized(using: "LabelTitle")
            englishSelectedLbl.text = ""
        }
        
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    

    @IBAction func englishBtnTapped(_ sender: Any) {
        Localize.setCurrentLanguage("en")
        titleLbl.text = "LANGUAGE".localized(using: "LabelTitle")
        englishSelectedLbl.text = "selected".localized(using: "LabelTitle")
        vnSelectedLbl.text = ""
    }
    
    @IBAction func vietnamBtnTapped(_ sender: Any) {
        Localize.setCurrentLanguage("vi")
        titleLbl.text = "LANGUAGE".localized(using: "LabelTitle")
        vnSelectedLbl.text = "selected".localized(using: "LabelTitle")
        englishSelectedLbl.text = ""
    }
    
}
