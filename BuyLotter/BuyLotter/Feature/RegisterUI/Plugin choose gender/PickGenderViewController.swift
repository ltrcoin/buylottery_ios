//
//  PickGenderViewController.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/9/12.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit
@objc protocol PickGenderDelegate {
    func changePickGender(_ str: String, index: Int)
    @objc optional func exitPopup()
}
class PickGenderViewController: UIViewController {
    @IBOutlet weak var maleBtn: UIButton!
    @IBOutlet weak var femaleBtn: UIButton!
    @IBOutlet weak var otherBtn: UIButton!
    
    var delegate: PickGenderDelegate?
    init() {
        
        super.init(nibName: "PickGenderViewController", bundle: nil)
    }
    
    init(_ delegate:PickGenderDelegate) {
        self.delegate = delegate
        super.init(nibName: "PickGenderViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        maleBtn.setTitle("Male".localized(using: "LabelTitle"), for: .normal)
        
        femaleBtn.setTitle("Female".localized(using: "LabelTitle"), for: .normal)
        
        otherBtn.setTitle("Other".localized(using: "LabelTitle"), for: .normal)
    }
    
    @IBAction func maleBtnTapped(_ sender: Any) {
        print("maleBtnTapped")
        delegate?.changePickGender("Male".localized(using: "LabelTitle"), index: 1)
        self.removeSelf(anime: .Center, _parentView: nil)
    }
    
    @IBAction func femaleBtnTapped(_ sender: Any) {
        print("femaleBtnTapped")
        delegate?.changePickGender("Female".localized(using: "LabelTitle"), index: 2)
        self.removeSelf(anime: .Center, _parentView: nil)
    }
    
    @IBAction func otherBtnTapped(_ sender: Any) {
        print("otherBtnTapped")
        delegate?.changePickGender("Other".localized(using: "LabelTitle"), index: 3)
        self.removeSelf(anime: .Center, _parentView: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
