//
//  MyGalleryCollectionViewCell.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/9/13.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit

protocol MyGalleryCollectionViewCellDelegate: class {
    func myGalleryCollectionViewCell(_ index:Int, didSelect image: Image)
    func myGalleryCollectionViewCell(_ index:Int, didDeSelect image: Image)
}

class MyGalleryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var choiceView: UIView!
    
    @IBOutlet weak var choiceImg: UIImageView!
    
    @IBOutlet weak var pickSinal: UIView!
    
    var index = 0
    var image:Image! {
        didSet{
            imageView.g_loadImage(image.asset)
        }
    }
    
    var isChoice = false {
        didSet{
            if isChoice {
                choiceImg.isHidden = false
                pickSinal.isHidden = false
            } else {
                choiceImg.isHidden = true
                pickSinal.isHidden = true
            }
        }
    }
    
    weak var delegate:MyGalleryCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layoutIfNeeded()
        choiceView.layer.borderWidth = 1
        choiceView.layer.cornerRadius = choiceView.frame.width / 2
        choiceView.layer.borderColor = UIColor.white.cgColor
        choiceView.g_addShadow()
        
        choiceImg.image = UIImage.init(named: "verify-icon")?.withRenderingMode(.alwaysTemplate)
        choiceImg.tintColor = .white
        choiceImg.isHidden = true
    }
    
    func setSelectStatus(_ value:Bool){
        isChoice = value
    }
    
    
    @IBAction func selectBtnTapped(_ sender: Any) {
        isChoice = !isChoice
        if isChoice {
            delegate?.myGalleryCollectionViewCell(index, didSelect: image)
        } else {
            delegate?.myGalleryCollectionViewCell(index, didDeSelect: image)
        }
        
    }
    
}
