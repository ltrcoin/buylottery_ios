//
//  Extension UIImageView imge social timeline.swift
//  SocialApp
//
//  Created by HieuTT on 07/08/2018.
//  Copyright © 2018 CNCVN. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

extension UIImageView {
    func setAvatarIcon(urlStr:String){
        let url = URL(string: urlStr)!
        let size = CGSize(width: 80.0, height: 80.0)
        let filter = AspectScaledToFillSizeWithRoundedCornersFilter(size: size, radius: 0)
        self.af_setImage(withURL: url, placeholderImage: nil, filter: filter)
    }

    func setTimelineImg(urlStr:String){
        let url = URL(string: urlStr)!
        let size = CGSize(width: 400.0, height: 400.0)
        let filter = AspectScaledToFillSizeWithRoundedCornersFilter(size: size, radius: 0)
        self.af_setImage(withURL: url, placeholderImage: nil, filter: filter)
    }

    func setTimelineImg(urlStr:String,ratio:Double) {
        let url = URL(string: urlStr)!
        let size = CGSize(width: 400 , height: 400 / ratio)
        let filter = AspectScaledToFillSizeWithRoundedCornersFilter(size: size, radius: 0)
        self.af_setImage(withURL: url, placeholderImage: nil, filter: filter)
    }
}
