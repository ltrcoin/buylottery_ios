//
//  ResultDetailView.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/10/4.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit

class ResultDetailView: UIView {
    var prizeData = PrizeModel()
    
    @IBOutlet weak var contentAreaView: UIView!
    
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var currentJackpotLbl: UILabel!
    
    @IBOutlet weak var timeDrawLbl: UILabel!
    
    @IBOutlet var numberViews: [NumberCircleView]!
    @IBOutlet weak var buyBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var heightTableViewCT: NSLayoutConstraint!
    let cellId = "PrizeTableViewCell"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        contentAreaView.layer.cornerRadius = 10
        buyBtn.layer.cornerRadius = 8
        updateViews()
        
        setupTestData()
        setupTableView()
        
        currentJackpotLbl.text = "Current jackpot".localized(using: "LabelTitle")
        
        buyBtn.setTitle("Buy A Ticket".localized(using: "ButtonTitle"), for: .normal)
    }
    
    func setupTestData(){

        prizeData.smallPrizeData.append(SmallPrizeModel.init(kind: "5+PB", value: 0))
        prizeData.smallPrizeData.append(SmallPrizeModel.init(kind: "5", value: 1000000))
        prizeData.smallPrizeData.append(SmallPrizeModel.init(kind: "4+PB", value: 10000))
        prizeData.smallPrizeData.append(SmallPrizeModel.init(kind: "4", value: 500))
        prizeData.smallPrizeData.append(SmallPrizeModel.init(kind: "3+PB", value: 200))
        prizeData.smallPrizeData.append(SmallPrizeModel.init(kind: "3", value: 10))
        prizeData.smallPrizeData.append(SmallPrizeModel.init(kind: "2+PB", value: 10))
        prizeData.smallPrizeData.append(SmallPrizeModel.init(kind: "1+PB", value: 5))
        prizeData.smallPrizeData.append(SmallPrizeModel.init(kind: "0+PB", value: 2))
    }
    
    
    @IBOutlet var view: UIView!
    
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
    
    func updateViews(){
        
        for i in 0..<numberViews.count {
            if i < prizeData.normalNumbers.count {
                numberViews[i].setupNormal(prizeData.normalNumbers[i])
            } else if i - prizeData.normalNumbers.count < prizeData.specialNumbers.count {
                numberViews[i].setupSpecial(prizeData.specialNumbers[i - prizeData.normalNumbers.count])
            } else {
                numberViews[i].isHidden = true
            }
        }
        
        timeDrawLbl.text = prizeData.drawDateStr
    }
    
    @IBAction func buyBtnTapped(_ sender: Any) {
        print("goto buy screen")
        let buyticketVC = BuyTicketViewController.init()
        self.parentViewController!.present(buyticketVC, animated: true, completion: nil)
    }
}


extension ResultDetailView : UITableViewDataSource, UITableViewDelegate {
    
    func setupTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 35
        tableView.backgroundView = nil
        tableView.allowsSelection = false
        
        heightTableViewCT.constant = CGFloat(35 * (prizeData.smallPrizeData.count + 1)) - 2
        
        tableView.register(UINib.init(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prizeData.smallPrizeData.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PrizeTableViewCell

        if indexPath.row == 0 {
            cell.noLbl.text = "Divisions".localized(using: "LabelTitle")
            cell.matchLbl.text = "Match".localized(using: "LabelTitle")
            cell.payoutLbl.text = "Payout".localized(using: "LabelTitle")
        } else {
            cell.noLbl.text = "\(indexPath.row)"
            cell.matchLbl.text = prizeData.smallPrizeData[indexPath.row - 1].kind
            if prizeData.smallPrizeData[indexPath.row - 1].value != 0 {
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                numberFormatter.allowsFloats = true
                numberFormatter.maximumFractionDigits = 6
                cell.payoutLbl.text = "USD " + prizeData.smallPrizeData[indexPath.row - 1].value.toStringFormat()
            } else {
                cell.payoutLbl.text = "No Winner".localized(using: "LabelTitle")
            }
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
}
