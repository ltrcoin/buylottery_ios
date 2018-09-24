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

        // Do any additional setup after loading the view.
    }
    
    @IBAction func maleBtnTapped(_ sender: Any) {
        print("maleBtnTapped")
        delegate?.changePickGender("Male", index: 1)
        self.removeSelf(anime: .Center, _parentView: nil)
    }
    
    @IBAction func femaleBtnTapped(_ sender: Any) {
        print("femaleBtnTapped")
        delegate?.changePickGender("Female", index: 2)
        self.removeSelf(anime: .Center, _parentView: nil)
    }
    
    @IBAction func otherBtnTapped(_ sender: Any) {
        print("otherBtnTapped")
        delegate?.changePickGender("Other", index: 3)
        self.removeSelf(anime: .Center, _parentView: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
