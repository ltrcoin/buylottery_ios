//
//  ImageFullScreenVC.swift
//  SatacusWorld
//
//  Created by KiD on 3/22/17.
//  Copyright © 2017 Hieu Tran. All rights reserved.
//

import UIKit
import AlamofireImage

class ImageFullScreenPageVC: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var imageHolderName = "defaultImage"
    var folderLink = ""
    
    var imageUrls: [String]! = []
    var images: [UIImage]! = []
    var currentIndex: Int = 0
    var originFrame: [CGRect]! = []

    let btnClose = UIView()
    let btnCloseImg: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "icon-close-2")?.withRenderingMode(.alwaysTemplate)
        iv.contentMode = .scaleAspectFill
        iv.tintColor = .white
        iv.layer.masksToBounds = false
        iv.layer.shadowColor = UIColor.black.cgColor
        iv.layer.shadowOpacity = 0.5
        iv.layer.shadowOffset = CGSize.zero
        iv.layer.shadowRadius = 1
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            self.tabBarController?.setTabBar(hidden: true)
        } else {
            self.tabBarController?.tabBar.isHidden = true
        }
        for index in 0..<imageUrls.count {
            imageUrls[index] = folderLink + imageUrls[index]
        }

        dataSource = self
        delegate = self
        self.view.backgroundColor = .black
        view.addSubview(btnClose)
        btnClose.addSubview(btnCloseImg)
        btnClose.frame = CGRect(x: self.view.frame.width / 2 - 20, y: self.view.frame.height - 45, width: 40.0, height: 40.0)
        btnCloseImg.frame = CGRect(x: 7, y: 7, width: 26.0, height: 26.0)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeImageFullScreenView))
        btnClose.addGestureRecognizer(tapGesture)
        
        let imageFullScreenVC = ImageFullScreenVC()
        if imageUrls.count == 0 {
            print("currentIndex:\(currentIndex): size:\(images.count)")
            imageFullScreenVC.img = images[currentIndex]
        } else {
            print("currentIndex:\(currentIndex): size:\(imageUrls.count)")
            imageFullScreenVC.imgUrl = imageUrls[currentIndex]
        }
        imageFullScreenVC.view.tag = currentIndex
        
        let viewControllers = [imageFullScreenVC]
        setViewControllers(viewControllers, direction: .forward, animated: true, completion: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        print("🤬 viewWillDisappear")
        if #available(iOS 11.0, *) {
            self.tabBarController?.setTabBar(hidden: false)
        } else {
            self.tabBarController?.tabBar.isHidden = false
        }
    }
    
    func showViewAnimation() {
        let superView = self.view.superview
        
        let mainImage = UIImageViewModeScaleAspect(frame: originFrame[currentIndex])
        mainImage.contentMode = .scaleAspectFill
        
        if imageUrls.count == 0 {
            mainImage.image = images[currentIndex]
        } else {
            let linkImage = imageUrls[currentIndex]
            print("===== show link image: \(linkImage)")
            if let url = URL(string: linkImage ) {
                let imageView = UIImageView()
                let placeholderImage = UIImage(named: imageHolderName)!
                imageView.af_setImage(withURL: url, placeholderImage: placeholderImage)
                mainImage.image = imageView.image
            }
        }
        superView?.addSubview(mainImage)
        
        mainImage.animate(.fit, frame: (superView?.bounds)!, duration: 0.3, delay: 0.0) { (completion) in
            self.navigationController?.navigationBar.isHidden = true
            mainImage.removeFromSuperview()
            self.view.isHidden = false
        }
    }
    
    
    @objc func closeImageFullScreenView() {

        self.navigationController?.navigationBar.isHidden = false
        let superView = self.view.superview
        self.view.removeFromSuperview()
        
        let mainImage = UIImageViewModeScaleAspect(frame: (superView?.bounds)!)
        mainImage.contentMode = .scaleAspectFit
        
        if imageUrls.count == 0 {
            mainImage.image = images[currentIndex]
        } else {
            if let url = URL(string:imageUrls[currentIndex]) {
                let imageView = UIImageView()
                let placeholderImage = UIImage(named: imageHolderName)!
                imageView.af_setImage(withURL: url, placeholderImage: placeholderImage)
                mainImage.image = imageView.image
            }
        }
        superView?.addSubview(mainImage)
        mainImage.animate(.fill, frame: originFrame[currentIndex], duration: 0.3, delay: 0.0) { (completion) in
            mainImage.removeFromSuperview()
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let viewController = viewController as! ImageFullScreenVC
        if imageUrls.count == 0 {
            var currentIndex = self.images.index(of: viewController.img)!
            if currentIndex > 0 {
                currentIndex -= 1
                let imageFullScreenVC = ImageFullScreenVC()
                imageFullScreenVC.img = images[currentIndex]
                imageFullScreenVC.view.tag = currentIndex
                return imageFullScreenVC
            }
        } else {
            var currentIndex = self.imageUrls.index(of: viewController.imgUrl)!
            if currentIndex > 0 {
                currentIndex -= 1
                let imageFullScreenVC = ImageFullScreenVC()
                imageFullScreenVC.imgUrl = imageUrls[currentIndex]
                imageFullScreenVC.view.tag = currentIndex
                return imageFullScreenVC
            }
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let viewController = viewController as! ImageFullScreenVC
        if imageUrls.count == 0 {
            var currentIndex = self.images.index(of: viewController.img)!
            if currentIndex < self.images.count - 1 {
                currentIndex += 1
                let imageFullScreenVC = ImageFullScreenVC()
                imageFullScreenVC.img = images[currentIndex]
                imageFullScreenVC.view.tag = currentIndex
                return imageFullScreenVC
            }
        } else {
            var currentIndex = self.imageUrls.index(of: viewController.imgUrl)!
            if currentIndex < self.imageUrls.count - 1 {
                currentIndex += 1
                let imageFullScreenVC = ImageFullScreenVC()
                imageFullScreenVC.imgUrl = imageUrls[currentIndex]
                imageFullScreenVC.view.tag = currentIndex
                return imageFullScreenVC
            }
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if (!completed)
        {
            return
        }
        self.currentIndex = pageViewController.viewControllers!.first!.view.tag
    }
}


class ImageFullScreenVC: UIViewController, UIScrollViewDelegate {
    var imageHolderName = "defaultImage"
    var imgUrl: String! = "" {
        didSet {
            if let url = URL(string:imgUrl) {
                let placeholderImage = UIImage(named: imageHolderName)!
                imageView.af_setImage(withURL: url, placeholderImage: placeholderImage, completion: { (completion) in
                    self.scrollView.display(image: self.imageView.image!)
                })

            }
        }
    }
    
    var img: UIImage! = UIImage(named: "defaultImage") {
        didSet {
            imageView.image = img
            scrollView.display(image: img)
        }
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //To Zoom-in and Zoom-out image
//    let scrollView: UIScrollView = {
//        let scrollView = UIScrollView()
//        
//        return scrollView
//    }()

    let scrollView = ImageScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        let topSpacing = CGFloat(0.0)
        scrollView.frame = CGRect(x: 0.0, y: topSpacing, width: view.bounds.width, height: view.bounds.height - topSpacing)
        scrollView.display(image: imageView.image!)
    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.addSubview(scrollView)
//        scrollView.addSubview(imageView)
//        scrollView.minimumZoomScale = 1.0
//        scrollView.maximumZoomScale = 6.0
//        
//        scrollView.delegate = self
//        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(zoomImageDoubleTap))
//        tapGesture.numberOfTapsRequired = 2
//        imageView.addGestureRecognizer(tapGesture)
//        imageView.isUserInteractionEnabled = true
//        
//        let topSpacing = CGFloat(0.0)
//        scrollView.frame = CGRect(x: 0.0, y: topSpacing, width: view.bounds.width, height: view.bounds.height - topSpacing)
//        imageView.frame = scrollView.bounds
//    }
//    
//    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
//        return self.imageView
//    }
//    
//    func zoomImageDoubleTap(recognizer: UITapGestureRecognizer) {
//        if self.scrollView.zoomScale > self.scrollView.minimumZoomScale {
//            self.scrollView.setZoomScale(self.scrollView.minimumZoomScale, animated: true)
//        } else {
//            scrollView.zoom(to: zoomRectForScale(scale: scrollView.maximumZoomScale, center: recognizer.location(in: recognizer.view)), animated: true)
//        }
//    }
//    
//    func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
//        var zoomRect = CGRect.zero
//        zoomRect.size.height = imageView.frame.size.height / scale
//        zoomRect.size.width  = imageView.frame.size.width  / scale
//
//        let newCenter = imageView.convert(center, from: scrollView)
//        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
//        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
//        return zoomRect
//    }
//
//    func scrollViewDidZoom(_ scrollView: UIScrollView) {
//        print(scrollView.bounds)
//        print(imageView.frame)
//    }
}
