//
//  MenuSideViewController.swift
//  MenuSide
//
//  Created by admin on 2018/9/5.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit

protocol MenuSideInterface {
    func showMenuSide()
    func hideMenuSide()
    func toggleMenuSide()
}

class MenuSideViewController: UIViewController, MenuSideInterface {

    @IBOutlet weak var expandBtn: UIButton!
    @IBOutlet weak var heighSubViewCT: NSLayoutConstraint!
    
    @IBOutlet weak var leftCT: NSLayoutConstraint!
    
    @IBOutlet weak var contentAreaView: UIView!
    
    var spaceExpandValue:CGFloat = 0
    var isExpand = true
    var isShowMenuSide = false
    
    var homeVC:HomeViewController!
    var signInVC:LoginViewController!
    
    var rectContent = CGRect.zero
    
    init() {
        super.init(nibName: "MenuSideViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        spaceExpandValue = self.view.frame.width * 0.6
        
        homeVC = HomeViewController.init(self)
        signInVC = UIStoryboard.init(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        homeVC.menuSide = self
        signInVC.menuSide = self
        rectContent.size = contentAreaView.frame.size
        
        self.add(signInVC, anime: .None, rect: rectContent, parentView: contentAreaView)
        self.add(homeVC, anime: .None, rect: rectContent, parentView: contentAreaView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
    }
    
    
    @IBAction func expandBtnTapped(_ sender: Any) {
        
        isExpand = !isExpand
        if isExpand {
            heighSubViewCT.constant = spaceExpandValue
        } else {
            heighSubViewCT.constant = 0
        }
        print("\(heighSubViewCT.constant)")
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    func toggleMenuSide() {
        isShowMenuSide = !isShowMenuSide
        if isShowMenuSide {
            showMenuSide()
        } else {
            hideMenuSide()
        }
    }
    
    func showMenuSide() {
        isShowMenuSide = true
        self.leftCT.constant = spaceExpandValue
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    func hideMenuSide() {
        isShowMenuSide = false
        self.leftCT.constant = 0
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func quitBtnTapped(_ sender: Any) {
        print("quit tapped")
        hideMenuSide()
    }
    
    @IBAction func homeBtnTapped(_ sender: Any) {
        print("home tapped")
        self.add(homeVC, anime: .None, rect: rectContent, parentView: contentAreaView)
        hideMenuSide()
    }
    
    @IBAction func resultBtnTapped(_ sender: Any) {
        print("result tapped")
    }
    
    @IBAction func winnersBtnTapped(_ sender: Any) {
        print("winner tapped")
    }
    
    @IBAction func signInBtnTapped(_ sender: Any) {
        print("sign in tapped")
        self.add(signInVC, anime: .None, rect: rectContent, parentView: contentAreaView)
        hideMenuSide()
    }
    
    @IBAction func signUpBtnTapped(_ sender: Any) {
        print("sign up tapped")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
