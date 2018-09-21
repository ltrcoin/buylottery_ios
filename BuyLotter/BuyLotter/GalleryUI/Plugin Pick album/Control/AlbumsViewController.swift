//
//  AlbumsViewController.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/9/13.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit
import Photos
protocol AlbumsViewControllerDelegate: class {
    func changeAlbum(_ controller: AlbumsViewController, didSelect album: Album)
}

class AlbumsViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var albums: [Album] = []
    
    weak var delegate: AlbumsViewControllerDelegate?
    
    var selectedIndex = 0
    
    init(_ albums: [Album]) {
        self.albums = albums
        super.init(nibName: "AlbumsViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorStyle = .none
        tableView.rowHeight = 84
    
        
        tableView.backgroundColor = UIColor.clear
        tableView.backgroundView = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
        
        tableView.register(AlbumCell.self, forCellReuseIdentifier: String(describing: AlbumCell.self))
    }
    
    @IBAction func quitBtnTapped(_ sender: Any) {
        self.removeSelf(anime: .Center, _parentView: nil, isHiddenBackground: true)
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AlbumCell.self), for: indexPath)
            as! AlbumCell

        let album = albums[(indexPath as NSIndexPath).row]
        cell.configure(album)
        cell.backgroundColor = UIColor.clear

        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let album = albums[(indexPath as NSIndexPath).row]
        delegate?.changeAlbum(self, didSelect: album)
        self.removeSelf(anime: .Center)
        selectedIndex = (indexPath as NSIndexPath).row
        tableView.reloadData()
        
    }
}
