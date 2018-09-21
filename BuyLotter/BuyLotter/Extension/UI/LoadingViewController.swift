//
//  LoadingViewController.swift
//  SocialApp
//
//  Created by HieuTT on 08/08/2018.
//  Copyright © 2018 CNCVN. All rights reserved.
//

import Foundation
import UIKit
class LoadingViewController: UIViewController {

    private lazy var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)

    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        let width = view.frame.width
        let height = view.frame.height
        view.frame = CGRect(x: width / 2 - 35, y: height / 2 - 35, width: 35, height: 35)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // We use a 0.5 second delay to not show an activity indicator
        // in case our data loads very quickly.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.activityIndicator.startAnimating()
        }
    }
    
}
