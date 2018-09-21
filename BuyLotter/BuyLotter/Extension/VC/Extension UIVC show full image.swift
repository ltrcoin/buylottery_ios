//
//  Extension UIVC show full image.swift
//  SatacusWorld
//
//  Created by Satacus on 28/01/2018.
//  Copyright © 2018 Hieu Tran. All rights reserved.
//

import UIKit

extension UIViewController {
    func showImageFullScreen(images: [UIImage], imageUrls: [String], currentIndex: Int, originFrame: [CGRect]) {
        print("show full all image")
        let imageFullScreenPageVC = ImageFullScreenPageVC(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [UIPageViewControllerOptionInterPageSpacingKey : 50.0])

        imageFullScreenPageVC.folderLink = ""
        imageFullScreenPageVC.images = images
        imageFullScreenPageVC.imageUrls = imageUrls
        imageFullScreenPageVC.currentIndex = currentIndex
        imageFullScreenPageVC.originFrame = originFrame

        self.addChildViewController(imageFullScreenPageVC)
        self.view.addSubview(imageFullScreenPageVC.view)
        imageFullScreenPageVC.view.isHidden = true
        imageFullScreenPageVC.showViewAnimation()
        self.didMove(toParentViewController: self)
    }
}
