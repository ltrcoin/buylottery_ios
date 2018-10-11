//
//  ListGamesViewController.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/10/5.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit

class ListGamesViewController: UIViewController {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    init() {
        super.init(nibName: "ListGamesViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

}
