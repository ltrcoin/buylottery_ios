//
//  HandPickNumberTicketViewController.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/9/26.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit

class HandPickNumberTicketViewController: UIViewController {
    weak var ticketVC:TicketViewController!
    var currentIndex:Int = 5
    
    
    var data:[TicketModel] = []
    
    var ticketRule:TicketRuleModel!
    var numberTicket = 10
    var isSystematic = false
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var widthContentCT: NSLayoutConstraint!
    
    @IBOutlet var ticketViews: [UIScrollView]!
    
    @IBOutlet var LeftTicketViewCTs: [NSLayoutConstraint]!

    @IBOutlet var RightTicketViewCTs: [NSLayoutConstraint]!
    
    @IBOutlet var ticketHandPickViews: [TicketHandPickView]!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var totalWidthContent:CGFloat = 0
    var space:CGFloat = 30
    var spaceTicket:CGFloat = 5
    
    
    var currentView = 0
    var firstIndex = 0
    var lastIndex = 0
    
    var width:CGFloat = 0
    var height:CGFloat = 0
    
    var numberView = 0
    
    var beginDragPoint:CGPoint = CGPoint.zero
    var endDragPoint:CGPoint = CGPoint.zero
    
    init(index:Int,ticketVC:TicketViewController) {
        self.ticketVC = ticketVC
        currentIndex = index
        
        self.ticketRule = ticketVC.ticketRule
        
        isSystematic = ticketVC.isSystematic
        
        if isSystematic {
            ticketRule.numberNormal = ticketVC.numberSystematic
            self.numberTicket = 1
            data.removeAll()
            data.append(ticketVC.systematicData)
        } else {
            self.numberTicket = ticketVC.numberTicket
            data = ticketVC.data
        }
        
        
        
        
        super.init(nibName: "HandPickNumberTicketViewController", bundle: nil)
    }
    
    deinit {
        print("🤬 HandPickNumberTicketViewController deinit")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTicketView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        if isSystematic {
            self.ticketVC.systematicData = data[0]
        } else {
            self.ticketVC.data = data
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateDataViews()
    }
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView(){
        
        scrollView.delegate = self
        
        width = scrollView.frame.width - space
        height = scrollView.frame.height
        
        totalWidthContent = CGFloat(numberTicket) * width + space
        widthContentCT.constant = totalWidthContent
        
        self.view.layoutIfNeeded()
        
        numberView = LeftTicketViewCTs.count
        lastIndex = numberView - 1
        
        
        if numberTicket < numberView {
            for _ in 0..<(numberView - numberTicket) {
                ticketViews.removeLast()
                LeftTicketViewCTs.removeLast()
                RightTicketViewCTs.removeLast()
                ticketHandPickViews.removeLast()
            }
            numberView = numberTicket
        }
        
        
        let tempJ = currentIndex <= numberTicket - numberView ? currentIndex : numberTicket - numberView
        if tempJ >= currentIndex {
            currentView = 0
        } else {
            currentView = currentIndex - tempJ
        } 
        for i in 0..<numberView {
            LeftTicketViewCTs[i].constant = CGFloat(i + tempJ) * width
            RightTicketViewCTs[i].constant = totalWidthContent - LeftTicketViewCTs[i].constant - width + spaceTicket
        }
        
        self.view.layoutIfNeeded()
        
        scrollView.contentOffset.x = CGFloat(currentIndex) * width
    }
    
    func updateDataViews(){
        for i in 0..<ticketViews.count {
            updateDataView(i)
        }
    }
    
    func updateDataView(_ i:Int) {
        let index = Int(ticketViews[i].frame.minX) / Int(width)
        ticketHandPickViews[i].index = index
        ticketHandPickViews[i].data = data[index]
        ticketHandPickViews[i].noLbl.text = "Line \(index + 1)/\(numberTicket)"
    }

}
