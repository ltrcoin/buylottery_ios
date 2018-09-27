//
//  HandPickNumberTicketViewController.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/9/26.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit

class HandPickNumberTicketViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let cellId = "HandPickTicketCollectionViewCell"
    
    var numberTicket = 10
    
    var beginDragPoint:CGPoint = CGPoint.zero
    var endDragPoint:CGPoint = CGPoint.zero
    
    init() {
        super.init(nibName: "HandPickNumberTicketViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 2
        layout.scrollDirection = .horizontal
        
        collectionView.backgroundColor = nil
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        collectionView.register(UINib.init(nibName: cellId, bundle: nil), forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberTicket
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HandPickTicketCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select cell:\(indexPath.item)")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return CGSize.init(width: self.collectionView.frame.size.width - 30, height: self.collectionView.frame.size.height)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollView.setContentOffset(scrollView.contentOffset, animated: false)
        endDragPoint = scrollView.contentOffset
        print("begin drag:\(beginDragPoint): end drag:\(endDragPoint)")
        
        
        let w = self.collectionView.frame.size.width - 30 + 2
        let index = CGFloat(Int(scrollView.contentOffset.x) / Int(w))
        let detal = CGFloat(Int(scrollView.contentOffset.x) % Int(w))
        print("detal:\(detal): index:\(index):width:\(w)")
        UIView.animate(withDuration: 1) {
            
            if self.endDragPoint.x > self.beginDragPoint.x {
                 scrollView.contentOffset.x = index * w + w
            } else {
                scrollView.contentOffset.x = index * w
            }
            
            
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        beginDragPoint = scrollView.contentOffset
    }

    
}
