//
//  Extension UIView loading.swift
//  CNCAPP
//
//  Created by HieuTT on 09/07/2018.
//  Copyright © 2018 CNCVN. All rights reserved.
//

import UIKit

extension UIView {
    func showLoading(style: UIActivityIndicatorView.Style = UIActivityIndicatorView.Style.gray){
        let loadingView = self.getLoadingView()
        loadingView.style = style
        loadingView.startAnimating()
    }

    func showLoading(rect: CGRect){
        let loadingView = self.getLoadingView()
        loadingView.frame = rect
        loadingView.startAnimating()
    }

    func showLoadingRight(style: UIActivityIndicatorView.Style = UIActivityIndicatorView.Style.white){
        let rect = CGRect(x: self.frame.width - self.frame.height, y: 0, width: self.frame.height, height: self.frame.height)
        self.showLoading(rect:rect)
    }

    func hideLoading(){
        let loadingView = self.getLoadingView()
        loadingView.stopAnimating()
    }

    func getLoadingView() -> UIActivityIndicatorView {
        if let loadingView = self.viewWithTag(88) as? UIActivityIndicatorView{
            return loadingView
        } else {
            let loadingIndicator = UIActivityIndicatorView()
            self.addSubview(loadingIndicator)
            loadingIndicator.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.height, height: self.frame.height)
            loadingIndicator.tag = 88
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = UIActivityIndicatorView.Style.gray
            return loadingIndicator
        }
    }

}

