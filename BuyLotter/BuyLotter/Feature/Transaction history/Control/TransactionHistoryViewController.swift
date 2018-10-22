//
//  TransactionHistoryViewController.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/10/18.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit

class TransactionHistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var menuSide:MenuSideInterface!
    
    @IBOutlet weak var menuImg: UIImageView!
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var transactionHistories:[TransactionHistoryModel] = []
    let cellId = "TransactionHistoryTableViewCell"
    
    init() {
        super.init(nibName: "TransactionHistoryViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuImg.image = UIImage.init(named: "menu")?.withRenderingMode(.alwaysTemplate)
        menuImg.tintColor = .white
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let username = UserDefaults.standard.string(forKey: "user-email"), let pwd = UserDefaults.standard.string(forKey: "user-pwd") {
            TransactionService.init().getHistory(username: username, pwd: pwd) {[weak self] (transactionHistories) in
                self?.transactionHistories = transactionHistories
                self?.tableView.reloadData()
            }
        }
    }

    @IBAction func menuSideBtnTapped(_ sender: Any) {
        menuSide.toggleMenuSide()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorStyle = .none
        tableView.register(UINib.init(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        
        tableView.rowHeight = 70
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionHistories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TransactionHistoryTableViewCell
        cell.data = transactionHistories[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webview = TransactionViewController.init(txhash: transactionHistories[indexPath.row].txHash)
        self.present(webview, animated: true, completion: nil)
    }
}
