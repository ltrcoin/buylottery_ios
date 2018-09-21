//
//  Extension MyGalleryVC collection view.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/9/13.
//  Copyright © 2018 kazy. All rights reserved.
//

import Foundation
import UIKit
extension MyGalleryViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func setupCollectionView(){
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        collectionView.register(UINib.init(nibName: "MyGalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellId)
        collectionView.register(UINib.init(nibName: "GalleryCamCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GalleryCamCollectionViewCellId")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCamCollectionViewCellId", for: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MyGalleryCollectionViewCell
            
            cell.image = items[indexPath.item - 1]
            cell.index = indexPath.item - 1
            if indexPath.item - 1 != indexSelected {
                cell.setSelectStatus(false)
            } else {
                cell.setSelectStatus(true)
            }
            
            cell.delegate = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            print("Show camera")
            btnImageFromCameraPressed()
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = (collectionView.bounds.size.width - 2 * 2)
            / 3
        return CGSize(width: size, height: size)
    }

    
}
