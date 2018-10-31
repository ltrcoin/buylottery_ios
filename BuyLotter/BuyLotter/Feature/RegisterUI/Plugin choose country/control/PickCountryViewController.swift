//
//  PickCountryViewController.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/9/11.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit
@objc protocol PickCountryDelegate {
    func changePickCountry(_ str: String, index: Int)
    @objc optional func exitPopup()
}

class PickCountryViewController: UIViewController  ,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var viewPickArea: UIView!
    
    
    var delegate: PickCountryDelegate?
    
    private var oldValue = ""
    
    init(_ oldValue:String) {
        self.oldValue = oldValue
        
        
        super.init(nibName: "PickCountryViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLbl.text = "Country ?".localized(using: "LabelTitle")
        searchBar.placeholder = "search".localized(using: "LabelTitle")
        searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib.init(nibName: "ViTriCell", bundle: nil), forCellReuseIdentifier: "ViTriCell")
        
        viewPickArea.layer.cornerRadius = 8
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if oldValue != "" {
            searchBar.text = oldValue
            updateSearchDataView(oldValue)
        }
        searchBar.becomeFirstResponder()
    }
    
    var arr = CountryConfig.data
    var arrSearch = CountryConfig.data
    
    
    @IBAction func closePress(_ sender: AnyObject) {
        self.removeSelf()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("number country:\(arr.count)")
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ViTriCell = tableView.dequeueReusableCell(withIdentifier: "ViTriCell", for: indexPath) as! ViTriCell
        
        cell.lbTinh?.text = arr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    
        var index = -1
        for i in 0..<(arrSearch.count - 1) {
            if arrSearch[i] == arr[indexPath.row] {
                index = i + 1
                break
            }
        }
        self.delegate?.changePickCountry(arr[indexPath.row], index: index)
        
        self.delegate?.exitPopup!()
        self.removeSelf()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        updateSearchDataView(searchText)
    }
    
    func updateSearchDataView(_ valueSearch:String){
        if valueSearch == "" {
            arr = arrSearch
            tableView.reloadData()
            return
        }else{
            let cv = ConvertString()
            let search = cv.convert(toUnsigned: valueSearch)
            arr = []
            for dic in CountryConfig.data {
                if dic.lowercased().range(of: search!) != nil {
                    arr.append(dic)
                }
            }
            tableView.reloadData()
        }
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
