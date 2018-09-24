//
//  Extension UIImageView show full image.swift
//  SatacusWorld
//
//  Created by Satacus on 28/01/2018.
//  Copyright © 2018 Hieu Tran. All rights reserved.
//

import UIKit

extension UIImageView {
    func getOriginFrame() -> CGRect {
        return (self.superview?.superview?.superview?.superview?.superview?.superview?.superview?.superview?.superview?.superview?.superview?.superview?.convert(self.frame, from: self.superview))!
    }
    
    func showImageFullScreen(currentIndex:Int = 0,imageUrls:[String] = [], frames:[CGRect] = [], currentImages: [UIImage] = []) {
        if let img = self.image {
            var originFrame = frames
            var images = currentImages
            images.append(img)
            if frames.count == 0 && imageUrls.count == 0{
                originFrame.append(getOriginFrame())
            } else if frames.count == 0 {
                for _ in 0..<imageUrls.count {
                    originFrame.append(getOriginFrame())
                }
            } else if frames.count < imageUrls.count {
                for _ in 1...(imageUrls.count - frames.count) {
                    originFrame.append(frames[frames.count - 1])
                }
            }

            self.parentViewController?.showImageFullScreen(images: images,imageUrls: imageUrls, currentIndex: currentIndex, originFrame: originFrame)
        }
    }
}
