//
//  HomeViewController.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/9/20.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var menuImg: UIImageView!
    @IBOutlet var playsBtn: [UIButton]!
    
    @IBOutlet weak var timeDrawLbl: UILabel!
    
    var et = 1000
    var mt = 2134
    
    var timer = Timer()
    
    var isShowMenuSide = false
    
    var menuSide:MenuSideInterface!
    
    init(_ menu: MenuSideInterface) {
        self.menuSide = menu
        super.init(nibName: "HomeViewController", bundle: nil)
    }
    init() {
        super.init(nibName: "HomeViewController", bundle: nil)
    }
    
    deinit {
        print("🤬 deinit HomeViewController")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlayBtnView()
        menuImg.image = UIImage.init(named: "menu")?.withRenderingMode(.alwaysTemplate)
        menuImg.tintColor = .white
        print("🤬 did load")
    }
    

    func setupPlayBtnView(){
        for btn in playsBtn {
            btn.layer.cornerRadius = 5
            btn.layer.masksToBounds = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        startTimeDown()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
    
    
    func startTimeDown(){
        
        timer  = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTimer() {
        et -= 1
        timeDrawLbl.text = timeString(time: TimeInterval(et))
    }
    
    func timeString(time:TimeInterval) -> String {
        let day = Int(time) / 86400
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%01i days %02i:%02i:%02i", day, hours, minutes, seconds)
    }
    
    @IBAction func menuSideTapped(_ sender: Any) {
        print("show menu side")
        self.menuSide.toggleMenuSide()
    }
    
    
    
    @IBAction func playBtnTapped(_ sender: Any) {
        if let pressedBtn = sender as? UIButton {
            for i in 0..<playsBtn.count {
                if pressedBtn == playsBtn[i] {
                    print(i)
                    break
                }
            }
        }
        
        let buyticketVC = BuyTicketViewController.init()
        self.add(buyticketVC, anime: .Right)
    }
    
    @IBAction func resultBtnTapped(_ sender: Any) {
        
    }
}
