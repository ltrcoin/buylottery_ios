//
//  BuyTicketViewController.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/9/24.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit

class BuyTicketViewController: UIViewController {

    @IBOutlet var numberBtns: [UIButton]!
    
    @IBOutlet var systematicNumberBtns: [UIButton]!
    
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var stackSystematicView: UIView!
    @IBOutlet weak var systematicBtn: UIButton!
    
    @IBOutlet weak var howToPlayLbl: UILabel!
    @IBOutlet weak var psSystematicLbl: UILabel!
    @IBOutlet weak var pickYourNumberLbl: UILabel!
    @IBOutlet weak var viewYourNumberLbl: UILabel!
    
    @IBOutlet weak var systematicHeightCT: NSLayoutConstraint!
    
    @IBOutlet weak var listTicksView: UIView!
    
    @IBOutlet weak var quickPickBtn: UIButton!
    @IBOutlet weak var buyBtn: UIButton!
    
    @IBOutlet weak var heighListTicketViewCT: NSLayoutConstraint!
    
    @IBOutlet weak var heightViewNumberCT: NSLayoutConstraint!
    @IBOutlet weak var heightBuyBtnCT: NSLayoutConstraint!
    var oldHeightBuyBtnCT:CGFloat = 0
    var oldHeightViewNumberCT:CGFloat = 0
    
    
    var oldSystematicHeightCT:CGFloat = 0
    var focusColor = UIColor.init(red: 80/255, green: 119/255, blue: 190/255, alpha: 1)
    
    var isSystematic = false
    
    var numberTitles = [3,5,7,10,15,20,25]
    var systematicTitles = [6,7,8,9,10,11]
    var systematicPSData = [6,21,56,126,252,462]
    
    var ticketVC:TicketViewController!
    
    var heightSymbolTicket:CGFloat!
    
    lazy var numberTicket = numberTitles[0]
    lazy var numberSystematic = systematicTitles[0]
    
    init() {
        super.init(nibName: "BuyTicketViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBtnView()
        backImg.image = UIImage(named: "back-icon")?.withRenderingMode(.alwaysTemplate)
        backImg.tintColor = .white
        
        view.layoutIfNeeded()
        oldSystematicHeightCT = systematicHeightCT.constant
        systematicHeightCT.constant = 0
        
        oldHeightViewNumberCT = heightViewNumberCT.constant
        heightViewNumberCT.constant = 0
        
        oldHeightBuyBtnCT = heightBuyBtnCT.constant
        heightBuyBtnCT.constant = 0
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if ticketVC == nil {
            ticketVC = TicketViewController.init()
            self.add(ticketVC, anime: .None, rect: CGRect.init(x: 0, y: 0, width: listTicksView.frame.width , height: listTicksView.frame.height), parentView: listTicksView)
            
            ticketVC.sizeCell = CGSize.init(width: (self.listTicksView.frame.width - ticketVC.cellSpace *  4) / 5, height: (self.listTicksView.frame.width - ticketVC.cellSpace *  4) / 5 * ticketVC.ratioTicket)
            print("🤬 ticketVC.sizeCell:\(ticketVC.sizeCell)")
            ticketVC.setupCollectionView()
            
            heightSymbolTicket = ticketVC.sizeCell.height
            
            
            heighListTicketViewCT.constant =  heightSymbolTicket * CGFloat((numberTicket - 1) / 5 + 1) +  ticketVC.lineSpace * CGFloat((numberTicket - 1) / 5)
            
            
            
            ticketVC.numberTicket = numberTicket
            ticketVC.collectionView.reloadData()
            
            
        }
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUIFollowLanguage()
        if ticketVC != nil {
            var isShowNumber = false
            var isShowBuy = false
            
            for ticket in ticketVC.data {
                if ticket.normal.count > 0 || ticket.special.count > 0 {
                    isShowNumber = true
                }
                if ticket.isFull {
                    isShowBuy = true
                }
            }
            
            if isShowNumber {
                showViewNumber()
            }
            if isShowBuy {
                showBuyBtn()
            }
        }
    }
    
    func updateUIFollowLanguage() {
        howToPlayLbl.text = "Choose how to play".localized(using: "LabelTitle")
        pickYourNumberLbl.text = "Pick your numbers".localized(using: "LabelTitle")
        viewYourNumberLbl.text = "View Your Numbers".localized(using: "LabelTitle")
        quickPickBtn.setTitle("Quick pick".localized(using: "ButtonTitle"), for: .normal)
        systematicBtn.setTitle("Systematic".localized(using: "ButtonTitle"), for: .normal)
        
        buyBtn.setTitle("Buy A Ticket".localized(using: "ButtonTitle"), for: .normal)
    }
    
    
    @IBAction func buyTicketTapped(_ sender: Any) {
        print("buy ticket tapped")
        if MenuSideViewController.Instance.isLogin {
            let checkoutVC = CheckoutViewController.init(ticketVC: ticketVC)
            self.present(checkoutVC, animated: true, completion: nil)
        } else {
            MenuSideViewController.Instance.signInBtnTapped(self)
        }
        
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.removeSelf(anime: .Right)
    }
    
    func setupBtnView(){
        for i in 0..<numberBtns.count {
            if i < numberTitles.count {
                numberBtns[i].layer.borderWidth = 1
                numberBtns[i].layer.cornerRadius = 5
                numberBtns[i].layer.borderColor = focusColor.cgColor
                numberBtns[i].setTitle("\(numberTitles[i])", for: .normal)
                
                
            } else {
                numberBtns[i].removeFromSuperview()
            }
            
        }
        
        for i in 0..<systematicNumberBtns.count {
            if i >= systematicTitles.count {
                systematicNumberBtns[i].removeFromSuperview()
            }
        }
        
        numberBtns[0].backgroundColor = focusColor
        numberBtns[0].setTitleColor(UIColor.white, for: .normal)
        
        systematicNumberBtns[0].backgroundColor = focusColor
        systematicNumberBtns[0].setTitleColor(UIColor.white, for: .normal)
        psSystematicLbl.text = "\(systematicTitles[0]) \("Numbers".localized(using: "LabelTitle")) = \(systematicPSData[0]) \("Lines".localized(using: "LabelTitle"))"
        
        systematicBtn.layer.borderWidth = 1
        systematicBtn.layer.cornerRadius = 5
        systematicBtn.layer.borderColor = focusColor.cgColor
        systematicBtn.backgroundColor = nil
        systematicBtn.setTitleColor(focusColor, for: .normal)
        
        quickPickBtn.layer.borderWidth = 1
        quickPickBtn.layer.cornerRadius = 5
        quickPickBtn.layer.borderColor = focusColor.cgColor
        quickPickBtn.backgroundColor = nil
        quickPickBtn.setTitleColor(focusColor, for: .normal)
        
        buyBtn.layer.cornerRadius = 5
        
        
        stackSystematicView.layer.borderWidth = 1
        stackSystematicView.layer.cornerRadius = 5
        stackSystematicView.layer.borderColor = focusColor.cgColor
    }
    
    @IBAction func numberBtnTapped(_ sender: Any) {
        ticketVC.isSystematic = false
        if let pressedBtn = sender as? UIButton {
            for i in 0..<numberBtns.count {
                if pressedBtn == numberBtns[i] {
                    print(i)
                    numberBtns[i].backgroundColor = focusColor
                    numberBtns[i].setTitleColor(UIColor.white, for: .normal)
                    
                    numberTicket = numberTitles[i]
                    heighListTicketViewCT.constant =  heightSymbolTicket * CGFloat((numberTicket - 1) / 5 + 1) +  ticketVC.lineSpace * CGFloat((numberTicket - 1) / 5)
                    UIView.animate(withDuration: 0.2) {
                        self.view.layoutIfNeeded()
                    }
                    
                    ticketVC.numberTicket = numberTicket
                    ticketVC.collectionView.reloadData()
                } else {
                    numberBtns[i].backgroundColor = nil
                    
                    numberBtns[i].setTitleColor(focusColor, for: .normal)
                }
            }
        }
        setHideSystematicNumber()
    }
    
    @IBAction func systematicBtnTapped(_ sender: Any) {

        systematicHeightCT.constant = oldSystematicHeightCT
        systematicBtn.setTitleColor(UIColor.white, for: .normal)
        systematicBtn.backgroundColor = focusColor
        
        
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
        resetNumberBtnFocus()
        
        
        heighListTicketViewCT.constant =  heightSymbolTicket / 2
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
        
        ticketVC.isSystematic = true
        ticketVC.collectionView.reloadData()
    }
    
    
    @IBAction func numberSystematicTapped(_ sender: Any) {
        if let pressedBtn = sender as? UIButton {
            for i in 0..<systematicNumberBtns.count {
                if pressedBtn == systematicNumberBtns[i] {
                    print(i)
                    systematicNumberBtns[i].backgroundColor = focusColor
                    systematicNumberBtns[i].setTitleColor(UIColor.white, for: .normal)
                    
                    numberSystematic = systematicTitles[i]
                    
                    psSystematicLbl.text = "\(systematicTitles[i]) \("Numbers".localized(using: "LabelTitle")) = \(systematicPSData[i]) \("Lines".localized(using: "LabelTitle"))"
                    
                    
                    ticketVC.numberSystematic = numberSystematic
                    ticketVC.collectionView.reloadData()
                } else {
                    systematicNumberBtns[i].backgroundColor = nil
                    
                    systematicNumberBtns[i].setTitleColor(focusColor, for: .normal)
                }
            }
        }
    }
    
    
    func resetNumberBtnFocus(){
        for i in 0..<numberBtns.count {
            numberBtns[i].backgroundColor = nil
            numberBtns[i].setTitleColor(focusColor, for: .normal)
        }
    }
    
    func setHideSystematicNumber(){
        systematicBtn.setTitleColor(focusColor, for: .normal)
        systematicBtn.backgroundColor = nil
        systematicHeightCT.constant = 0
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func explainSystematicBtnTapped(_ sender: Any) {
        print("show explain systematic")
        let guideSystematicVC = GuideSystematicViewController.init()
        self.present(guideSystematicVC, animated: true, completion: nil)
    }
    
    @IBAction func quickPickBtnTapped(_ sender: Any) {
        ticketVC.startAnime()
        ticketVC.startRandom()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.showViewNumber()
            self.showBuyBtn()
        }
    }
    
    func showViewNumber(){
        self.heightViewNumberCT.constant = self.oldHeightViewNumberCT
        
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func showBuyBtn(){
        heightBuyBtnCT.constant = oldHeightBuyBtnCT
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    @IBAction func viewNumbersBtnTapped(_ sender: Any) {
        print("view numbers:\(ticketVC.data)")
        let viewYourNumbersVC = ViewYourNumbersViewController.init(ticketVC: ticketVC)
        self.present(viewYourNumbersVC, animated: true, completion: nil)
    }
    
}
