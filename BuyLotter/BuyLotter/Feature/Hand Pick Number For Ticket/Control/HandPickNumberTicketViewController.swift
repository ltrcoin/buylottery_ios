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
    var maxNumberNormal = 0
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var widthContentCT: NSLayoutConstraint!
    
    @IBOutlet var ticketViews: [UIScrollView]!
    
    @IBOutlet var LeftTicketViewCTs: [NSLayoutConstraint]!

    @IBOutlet var RightTicketViewCTs: [NSLayoutConstraint]!
    
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
    
    @IBOutlet var backgroundTicketViews: [UIView]!
    
    @IBOutlet var contentAreaTicketViews: [UIView]!
    
    @IBOutlet var quickPickBtns: [UIButton]!
    
    @IBOutlet var noTicketLbls: [UILabel]!
    
    @IBOutlet var quitImgs: [UIImageView]!
    
    
    @IBOutlet var normalCollectionViews: [UICollectionView]!
    
    @IBOutlet var heightNormalCTs: [NSLayoutConstraint]!
    
    @IBOutlet var specialCollectionViews: [UICollectionView]!
    
    @IBOutlet var heightSpecialCTs: [NSLayoutConstraint]!
    
    
    let cellId = "HandPickTicketCollectionViewCell"
    
    var cellSize:CGSize = CGSize.zero
    var numberColumn = 8
    
    var colorFullBackground = UIColor.init(red: 132/255, green: 192/255, blue: 242/255, alpha: 1)
    
    var colorFullContent = UIColor.init(red: 188/255, green: 219/255, blue: 244/255, alpha: 1)
    
    var colorNotFullBackground = UIColor.init(red: 247/255, green: 205/255, blue: 95/255, alpha: 1)
    
    var colorNotFullContent = UIColor.init(red: 249/255, green: 219/255, blue: 139/255, alpha: 1)
    
    
    
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
        
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
        
        for i in 0..<quickPickBtns.count {
            quickPickBtns[i].layer.cornerRadius = 5
            
            backgroundTicketViews[i].layer.cornerRadius = 5
        }
    }
    
    @IBAction func quitBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func quickPickBtnTapped(_ sender: Any) {
        print("quick pick tapped")
        
        randomTicketAnimation()
        
        
    }
    
    @IBAction func deleteBtn(_ sender: Any) {
        print("delete or reset number")
        data[currentIndex] = TicketModel()
        updateDataView(currentView)
    }
    
    

}
