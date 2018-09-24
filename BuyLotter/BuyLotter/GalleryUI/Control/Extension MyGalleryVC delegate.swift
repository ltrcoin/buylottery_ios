//
//  Extension MyGalleryVC delegate.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/9/14.
//  Copyright © 2018 kazy. All rights reserved.
//

import Foundation
extension MyGalleryViewController: AlbumsViewControllerDelegate, MyGalleryCollectionViewCellDelegate {
    func changeAlbum(_ controller: AlbumsViewController, didSelect album: Album) {
        show(album: album)
    }
    
    func myGalleryCollectionViewCell(_ index: Int, didSelect image: Image) {
        if indexSelected >= 0 {
            if let cell = collectionView.cellForItem(at: IndexPath.init(row: indexSelected + 1, section: 0)) as? MyGalleryCollectionViewCell {
                cell.setSelectStatus(false)
            }
        }

        imageSelected = image
        indexSelected = index
        let cell = collectionView.cellForItem(at: IndexPath.init(row: index + 1, section: 0)) as! MyGalleryCollectionViewCell
        cell.setSelectStatus(true)
    }
    
    func myGalleryCollectionViewCell(_ index: Int, didDeSelect image: Image) {
        indexSelected = -1
    }
}
