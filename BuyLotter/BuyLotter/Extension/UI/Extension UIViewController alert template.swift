//
//  Extension UIViewController alert template.swift
//  CNCAPP
//
//  Created by HieuTT on 09/07/2018.
//  Copyright © 2018 CNCVN. All rights reserved.
//

import UIKit

extension UIViewController {

    func alertOkCancel(title:String, message:String, handleCompletion: @escaping (Int) -> Void){
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)

        let cancel = UIAlertAction(title: "Không", style: .cancel, handler: { (action) -> Void in
            handleCompletion(0)
        })
        let ok = UIAlertAction(title: "Đồng ý", style: .default, handler: { (action) -> Void in
            handleCompletion(1)
        })

        alert.addAction(cancel)
        alert.addAction(ok)


        self.present(alert, animated: true, completion: nil)
    }

    func alertOk(title:String, message:String, handleCompletion: @escaping () -> Void){
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)


        let ok = UIAlertAction(title: "Đồng ý", style: .default, handler: { (action) -> Void in
            handleCompletion()
        })

        alert.addAction(ok)

        self.present(alert, animated: true, completion: nil)
    }

    func alertGetImg(title:String, message:String, handleCompletion: @escaping (Int) -> Void){

        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)

        let cancel = UIAlertAction(title: "Không", style: .cancel, handler: { (action) -> Void in
            handleCompletion(0)
        })
        let camera = UIAlertAction(title: "Máy ảnh", style: .default, handler: { (action) -> Void in
            handleCompletion(1)
        })
        let library = UIAlertAction(title: "Thư viện", style: .default, handler: { (action) -> Void in
            handleCompletion(2)
        })

        alert.addAction(cancel)
        alert.addAction(camera)
        alert.addAction(library)
        self.present(alert, animated: true, completion: nil)
    }

    func alertPassword(title:String, message:String, handleCompletion: @escaping (Int,String) -> Void){
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.keyboardAppearance = .dark
            textField.keyboardType = .default
            textField.isSecureTextEntry = true
            textField.autocorrectionType = .default
            textField.placeholder = "Nhập mật khẩu"
            textField.clearButtonMode = .whileEditing
        }

        let cancel = UIAlertAction(title: "Không", style: .destructive, handler: { (action) -> Void in
            handleCompletion(0,"")
        })
        let ok = UIAlertAction(title: "Đồng ý", style: .default, handler: { (action) -> Void in
            let textField = alert.textFields![0]
            handleCompletion(1,textField.text!)
        })

        alert.addAction(cancel)
        alert.addAction(ok)

        self.present(alert, animated: true, completion: nil)
    }

    func alertTextfield(title:String, message:String, placeHolder:String, handleCompletion: @escaping (Int,String) -> Void){
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.keyboardAppearance = .dark
            textField.keyboardType = .default
            textField.returnKeyType = .done
            textField.autocorrectionType = .default
            textField.placeholder = placeHolder
            textField.clearButtonMode = .whileEditing
        }

        let cancel = UIAlertAction(title: "Huỷ", style: .destructive, handler: { (action) -> Void in
            handleCompletion(0,"")
        })
        let ok = UIAlertAction(title: "Xong", style: .default, handler: { (action) -> Void in
            let textField = alert.textFields![0]
            handleCompletion(1,textField.text!)
        })

        alert.addAction(cancel)
        alert.addAction(ok)

        self.present(alert, animated: true, completion: nil)
    }

    func alertErrorNetwork(){
        let alert = UIAlertController(title: "KHÔNG CÓ INTERNET",
                                      message: "Xin hãy kiểm tra lại mạng",
                                      preferredStyle: .alert)

        let ok = UIAlertAction(title: "Đồng ý", style: .default, handler: { (action) -> Void in
        })

        alert.addAction(ok)

        self.present(alert, animated: true, completion: nil)
    }
}
