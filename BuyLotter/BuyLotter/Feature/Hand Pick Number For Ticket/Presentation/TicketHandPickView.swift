//
//  TicketHandPickView.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/9/28.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit

protocol TicketHandPickViewDelegate: class {
    func ticketHandPickView(_ ticket: TicketHandPickView, animationBeginAt index:Int)
    
    func ticketHandPickView(_ ticket: TicketHandPickView, animationEndAt index:Int)
    
    func ticketHandPickView(_ ticket: TicketHandPickView, resetAt index:Int)
    
    func ticketHandPickView(_ ticket: TicketHandPickView, toggleNumberAt index:Int)
    
    func ticketHandPickView(_ ticket: TicketHandPickView, exitAt index:Int)
}

class TicketHandPickView: UIView {
    var ticketRule:TicketRuleModel!
    var data:TicketModel! {
        didSet {
            updateDataView()
        }
    }
    var index = 0
    
    weak var delegate:TicketHandPickViewDelegate?
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var contentAreaView: UIView!
    
    @IBOutlet weak var noLbl: UILabel!
    @IBOutlet weak var quickPickBtn: UIButton!
    @IBOutlet weak var quitImg: UIImageView!
    
    @IBOutlet weak var countDownSpecialLbl: UILabel!
    @IBOutlet weak var countDownNormalLbl: UILabel!
    
    @IBOutlet weak var normalCollectionView: UICollectionView!
    
    @IBOutlet weak var specialCollectionView: UICollectionView!
    
    @IBOutlet weak var heightNormalCT: NSLayoutConstraint!
    
    @IBOutlet weak var heightSpecialCT: NSLayoutConstraint!
    
    let cellId = "HandPickTicketCollectionViewCell"
    
    var cellSize:CGSize = CGSize.zero
    var numberColumn = 8
    
    var colorFullBackground = UIColor.init(red: 132/255, green: 192/255, blue: 242/255, alpha: 1)
    
    var colorFullContent = UIColor.init(red: 188/255, green: 219/255, blue: 244/255, alpha: 1)
    
    var colorNotFullBackground = UIColor.init(red: 247/255, green: 205/255, blue: 95/255, alpha: 1)
    
    var colorNotFullContent = UIColor.init(red: 249/255, green: 219/255, blue: 139/255, alpha: 1)
    
    deinit {
        print("🤬 TicketHandPickView deinit")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        setupCollectionViews()
    }
    
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
    
    
    func setupView(){
        quickPickBtn.layer.cornerRadius = 5
        heightNormalCT.constant = CGFloat((ticketRule.maxNormal - 1) / 8 + 1) * (cellSize.height + 2)
        heightSpecialCT.constant = CGFloat((ticketRule.maxSpecial - 1) / 8 + 1) * (cellSize.height + 2)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
    }
    
    
    @IBAction func resetTicket(_ sender: Any) {
        delegate?.ticketHandPickView(self, resetAt: index)
    }
    
    @IBAction func quickPickBtnTapped(_ sender: Any) {
        delegate?.ticketHandPickView(self, animationBeginAt: index)
        randomTicketAnimation()
    }
    
    @IBAction func quitBtnTapped(_ sender: Any) {
        delegate?.ticketHandPickView(self, exitAt: index)
    }
    
}
