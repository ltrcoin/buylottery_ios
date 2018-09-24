//
//  MyGalleryViewController.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/9/13.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit
protocol MyGalleryViewControllerDegelate: class {
    func myGalleryViewController(didSelect image:Image)
    func myGalleryViewController(takePhoto image:UIImage)
}

class MyGalleryViewController: UIViewController {
    
    @IBOutlet weak var quitImg: UIImageView!
    @IBOutlet weak var albumNameLbl: UILabel!
    
    @IBOutlet weak var downIcon: UIImageView!
    
    @IBOutlet weak var doneLbl: UILabel!
    
    @IBOutlet weak var doneBtn: UIButton!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellId = "MyGalleryCollectionViewCellId"
    
    var items: [Image] = []
    let library = ImagesLibrary()
    let once = Once()
    var selectedAlbum: Album?
    var indexAlbum:Int = 0
    
    var imageSelected:Image!
    var indexSelected = -1 {
        didSet{
            if indexSelected >= 0 {
                doneLbl.isHidden = false
                doneBtn.isHidden = false
            } else {
                doneLbl.isHidden = true
                doneBtn.isHidden = true
            }
        }
    }
    
    weak var delegate:MyGalleryViewControllerDegelate?
    
    init() {
        super.init(nibName: "MyGalleryViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
        pageDidShow()
    }
    
    func setupView(){
        quitImg.image = UIImage.init(named: "x-icon")?.withRenderingMode(.alwaysTemplate)
        quitImg.g_addShadow()
        quitImg.tintColor = .white
        
        downIcon.image = UIImage.init(named: "down-icon")?.withRenderingMode(.alwaysTemplate)
        downIcon.tintColor = .white
    }
    
    
    @IBAction func quitBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func showAlbumBtnTapped(_ sender: Any) {
        print("show album")
        let albumVC = AlbumsViewController.init(library.albums)
        albumVC.delegate = self
        self.add(albumVC, anime: .ScrollTop)
    }
    
    
    @IBAction func doneBtnTapped(_ sender: Any) {
        print("done")
        delegate?.myGalleryViewController(didSelect: imageSelected)
        self.dismiss(animated: true, completion: nil)
    }
    
    func show(album: Album) {
        albumNameLbl.text =  album.collection.localizedTitle ?? ""
        items = album.items
        print("🤐 got images:\(items.count)")
        collectionView.reloadData()
    }
    
    func refreshSelectedAlbum() {
        if let selectedAlbum = selectedAlbum {
            selectedAlbum.reload()
            show(album: selectedAlbum)
        }
    }
    
    func changeAlbum(){
        indexAlbum += 1
        if indexAlbum >= self.library.albums.count {
            indexAlbum = 0
        }
    
        self.selectedAlbum = self.library.albums[indexAlbum]
        refreshSelectedAlbum()
    }
    
    func pageDidShow() {
        once.run {
            library.reload {
                if let album = self.library.albums.first {
                    self.selectedAlbum = album
                    self.show(album: album)
                }
            }
        }
    }

}
