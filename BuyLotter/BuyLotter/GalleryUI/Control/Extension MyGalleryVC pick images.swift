//
//  Extension RegisterVC pick images.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/9/12.
//  Copyright © 2018 kazy. All rights reserved.
//

import Foundation
import Photos

extension MyGalleryViewController :UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func choosePhoto(){
        print("Choose photo")
        let imgPicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            imgPicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            
            imgPicker.delegate = self
            imgPicker.allowsEditing = false
            self.present(imgPicker, animated: true, completion: nil)
        }
    }
    
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
         let chooseImg = info["UIImagePickerControllerOriginalImage"] as! UIImage
//         let asset = info[UIImagePickerControllerPHAsset] as! PHAsset
        //imageSelected = Image.init(asset: asset)
        
        //let imgValue = max(chooseImg.size.width, chooseImg.size.height)
       // var imgData:Data
        //        if imgValue > 3000 {
        //            imgData = UIImageJPEGRepresentation(chooseImg, 0.1)!
        //        } else if imgValue > 2000 {
        //            imgData = UIImageJPEGRepresentation(chooseImg, 0.3)!
        //        } else {
        //            imgData = UIImage(chooseImg)!
        //        }
//        if self.imgChoosing != nil {
//            if self.imgChoosing == self.portraitImg {
//                imagePortraitCam.isHidden = true
//            } else {
//                imagePassportCam.isHidden = true
//            }
//
//            self.imgChoosing?.image = chooseImg //UIImage(data: imgData)
//        }
        
        print("da chon duoc anh")
        dismiss(animated: false) {
            self.delegate?.myGalleryViewController(takePhoto: chooseImg)
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    func btnImageFromCameraPressed() {
        
        let imgPicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imgPicker.sourceType = UIImagePickerController.SourceType.camera
            
            imgPicker.delegate = self
            imgPicker.allowsEditing = false
            self.present(imgPicker, animated: true, completion: nil)
        } else {
            print("Don't have camera")
            self.alertOk(title: "Camera".localized(using: "LabelTitle"), message: "Don't have camera".localized(using: "LabelTitle")) {
            }
        }
        
    }
}
