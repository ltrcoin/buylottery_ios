//
//  ResultDetailViewController.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/10/4.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit

class ResultDetailViewController: UIViewController {
    
    var menuSide:MenuSideInterface!
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var nextAreaView: UIView!
    @IBOutlet weak var previousAreaView: UIView!
    @IBOutlet weak var nextDateLbl: UILabel!
    @IBOutlet weak var nextTimeLbl: UILabel!
    @IBOutlet weak var previousDateLbl: UILabel!
    @IBOutlet weak var previousTimeLbl: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var widthContentCT: NSLayoutConstraint!
    
    @IBOutlet var pageViews: [UIScrollView]!
    
    @IBOutlet var LeftTicketViewCTs: [NSLayoutConstraint]!
    
    @IBOutlet var RightTicketViewCTs: [NSLayoutConstraint]!
    
    @IBOutlet var pageContentViews: [ResultDetailView]!
    
    var prizeData:[PrizeModel] = []
    
    var numberPage:Int = 10
    var currentIndexPage:Int = 0
    
    var totalWidthContent:CGFloat = 0
    var space:CGFloat = 0
    
    var isPaging = false
    var currentIndexContentPageView = 0
    var firstIndex = 0
    var lastIndex = 0
    
    var width:CGFloat = 0
    var height:CGFloat = 0
    
    var numberPageContentView = 0
    
    var beginDragPoint:CGPoint = CGPoint.zero
    var endDragPoint:CGPoint = CGPoint.zero

    
    init() {
        super.init(nibName: "ResultDetailViewController", bundle: nil)
    }
    
    deinit {
        print("🤬 ResultDetailViewController")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implement here")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        ResultService().getWinningNumbers {[weak self] (prizeData) in
            print(prizeData)
            self?.prizeData = prizeData
            self?.setupView()
            self?.updateDataViews()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("😳 view will appear")
        updateUIFollowLanguage()
    }
    
    func updateUIFollowLanguage() {
        titleLbl.text = "Prize Breakdown".localized(using: "LabelTitle")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("😳 view will appear")
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        menuSide.toggleMenuSide()
    }
    
    @IBAction func nextResultBtnTapped(_ sender: Any) {
        leftPage()
    }
    
    @IBAction func previousResultBtnTapped(_ sender: Any) {
        rightPage()
    }
    
    
    func setupView(){
        numberPage = prizeData.count
        
        scrollView.delegate = self
        
        width = scrollView.frame.width - space
        height = scrollView.frame.height
        
        totalWidthContent = CGFloat(numberPage) * width + space
        widthContentCT.constant = totalWidthContent
        
        self.view.layoutIfNeeded()
        
        numberPageContentView = LeftTicketViewCTs.count
        lastIndex = numberPageContentView - 1
        
        
        if numberPage < numberPageContentView {
            for _ in 0..<(numberPageContentView - numberPage) {
                pageViews.removeLast()
                LeftTicketViewCTs.removeLast()
                RightTicketViewCTs.removeLast()
                pageContentViews.removeLast()
            }
            numberPageContentView = numberPage
        }
        
        
        let tempJ = currentIndexPage <= numberPage - numberPageContentView ? currentIndexPage : numberPage - numberPageContentView
        
        if tempJ >= currentIndexPage {
            currentIndexContentPageView = 0
        } else {
            currentIndexContentPageView = currentIndexPage - tempJ
        }
        
        for i in 0..<numberPageContentView {
            LeftTicketViewCTs[i].constant = CGFloat(i + tempJ) * width
            RightTicketViewCTs[i].constant = totalWidthContent - LeftTicketViewCTs[i].constant - width
        }
        
        self.view.layoutIfNeeded()
        
        scrollView.contentOffset.x = CGFloat(currentIndexPage) * width
        
        nextAreaView.isHidden = true
    }
    
    func updateDataViews(){
        for i in 0..<pageViews.count {
            updateDataView(i)
        }
    }
    
    func updateDataView(_ i:Int) {
        let index = Int(pageViews[i].frame.minX) / Int(width)
        pageContentViews[i].prizeData = prizeData[index]
        pageContentViews[i].updateViews()
    }

}
