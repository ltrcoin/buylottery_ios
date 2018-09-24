import UIKit
import Photos

extension UIImageView {

    func g_loadImage(_ asset: PHAsset, isMaxSize:Bool = false) {
    guard frame.size != CGSize.zero else {
      image = UIImage.init(named: "gallery_placeholder")
      return
    }

    if tag == 0 {
      image = UIImage.init(named: "gallery_placeholder")
    } else {
      PHImageManager.default().cancelImageRequest(PHImageRequestID(tag))
    }

    let options = PHImageRequestOptions()
    options.isNetworkAccessAllowed = true

    let id = PHImageManager.default().requestImage(
      for: asset, 
      targetSize: CGSize.init(width: asset.pixelWidth, height: asset.pixelHeight),
      contentMode: .aspectFit,
      options: options) { [weak self] image, _ in
      self?.image = image
    }
    
    tag = Int(id)
  }
    
}
