//
//  ViewYourNumbersViewController.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/9/26.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit

class ViewYourNumbersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var quickPickBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    let cellId = "ViewYourNumbersTableViewCell"
    
    
    var ticketVC:TicketViewController!
    
    var ticketRule:TicketRuleModel!
    var numberSystematic = 0
    var data:[TicketModel] = []
    var systematicData:TicketModel!
    var isSystematic = false
    

    var focusColor = UIColor.init(red: 80/255, green: 119/255, blue: 190/255, alpha: 1)
    
    init(ticketVC:TicketViewController) {
        self.ticketVC = ticketVC
        super.init(nibName: "ViewYourNumbersViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        ticketRule = ticketVC.ticketRule
        isSystematic = ticketVC.isSystematic
        
        if ticketVC.isSystematic {
            systematicData = ticketVC.systematicData
            numberSystematic = ticketVC.numberSystematic
            
            titleLbl.text = "1 \("lines".localized(using: "LabelTitle"))"
        } else {
            data = ticketVC.data
            titleLbl.text = "\(data.count) \("lines".localized(using: "LabelTitle"))"
        }
        quickPickBtn.setTitle("Quick Pick".localized(using: "ButtonTitle"), for: .normal)
        quickPickBtn.layer.borderWidth = 1
        quickPickBtn.layer.cornerRadius = 5
        quickPickBtn.layer.borderColor = focusColor.cgColor
        quickPickBtn.backgroundColor = nil
        quickPickBtn.setTitleColor(focusColor, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if isSystematic {
            ticketVC.systematicData = systematicData
        } else {
            ticketVC.data = data
        }
    }

    func setupTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib.init(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 100
    }
    
    @IBAction func quickPickBtnTapped(_ sender: Any) {
        if isSystematic {
            systematicData = RandomTicket().randSystematicTicket(numberSystematic: numberSystematic, rule: ticketRule)
        } else {
            data = RandomTicket().randListTickets(number: data.count, rule: ticketRule)
        }
        
        tableView.reloadData()
    }
    
    @IBAction func quitBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSystematic {
            return 1
        }
        return data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ViewYourNumbersTableViewCell
        cell.noLbl.text = "#\(indexPath.row + 1)"
        if isSystematic {
            cell.normalLbl.text = systematicData.normalStr()
            cell.specialLbl.text = systematicData.specialStr()
        } else {
            cell.normalLbl.text = data[indexPath.row].normalStr()
            cell.specialLbl.text = data[indexPath.row].specialStr()
        }
        
        return cell
    }
    
    

}
