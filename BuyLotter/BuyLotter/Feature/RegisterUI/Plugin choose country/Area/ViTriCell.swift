//
//  ViTriCell.swift
//  PriSchool
//
//  Created by Tiểu Linh Ngư on 8/25/16.
//  Copyright © 2016 Tiểu Linh Ngư. All rights reserved.
//

import UIKit

class ViTriCell: UITableViewCell {
    @IBOutlet weak var viewCha: UIView!
    @IBOutlet weak var lbTinh: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewCha.layer.shadowColor = UIColor.black.cgColor
        self.viewCha.layer.cornerRadius = 5
        self.viewCha.layer.borderColor = UIColor.lightGray.cgColor
        self.viewCha.layer.borderWidth = 0.5
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
