//
//  RegisterPageThreeViewController.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/9/17.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit

class RegisterPageThreeViewController: UIViewController, UITextFieldDelegate {
    
    var model = RegisterModel()
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var inputAreaView: UIView!
    
    @IBOutlet weak var walletBtnTxt: UITextField!
    
    @IBOutlet weak var addressTxt: UITextField!
    
    @IBOutlet weak var portraitImg: UIImageView!
    
    @IBOutlet weak var imagePortraitCam: UIImageView!
    
    @IBOutlet weak var passportImg: UIImageView!
    
    @IBOutlet weak var imagePassportCam: UIImageView!
    
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBOutlet weak var spaceBottomCT: NSLayoutConstraint!
    
    var oldConstraint:CGFloat = 0
    
    var imgChoosing:UIImageView?
    var isChangePortrait = false
    
    var viewFocus:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
        setupDelegate()
    }
    
    func setupDelegate(){
        walletBtnTxt.delegate = self
        addressTxt.delegate = self
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("\(textField.frame.maxY)")
        viewFocus = textField
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addKeyboardEvent()
        oldConstraint = spaceBottomCT.constant
    }
    
    @IBAction func dismissKeyboardTapped(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeKeyboardEvent()
    }

    @IBAction func portraitBtnTapped(_ sender: Any) {
        imgChoosing = portraitImg
        isChangePortrait = true
        let galleryVC = MyGalleryViewController.init()
        galleryVC.delegate = self
        self.present(galleryVC, animated: true, completion: nil)
    }
    
    @IBAction func passportBtnTapped(_ sender: Any) {
        imgChoosing = passportImg
        isChangePortrait = false
        let galleryVC = MyGalleryViewController.init()
        galleryVC.delegate = self
        self.present(galleryVC, animated: true, completion: nil)
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitBtnTapped(_ sender: Any) {
        submitBtn.isUserInteractionEnabled = false
        submitBtn.showLoadingRight(style: .white)
        
        RegisterService().register(email: model.email, pwd: model.password, fullname: model.fullname, phone: model.tel, walletBtc: walletBtnTxt.text, dob: model.dob, sex: model.sex, country: model.country, address: addressTxt.text, portraitImg: portraitImg.image, passportImg: passportImg.image) { [weak self] (done, msg, data) in
            
            
            
            self?.submitBtn.isUserInteractionEnabled = true
            self?.submitBtn.hideLoading()
            
            self?.dismiss(animated: true, completion: nil)
        }
    }
    
    
    func setupView(){
        inputAreaView.layer.borderWidth = 1
        inputAreaView.layer.cornerRadius = 8
        inputAreaView.layer.borderColor =  UIColor.init(red: 158/255, green: 175/255, blue: 174/255, alpha: 1).cgColor
        
        submitBtn.layer.cornerRadius = 5
    }
    
    override func keyboardWillShow(heightKeyboard: CGFloat) {
        spaceBottomCT.constant = heightKeyboard + 5
        if let _ = viewFocus {
            let frame = viewFocus?.superview?.convert((viewFocus?.frame)!, to: self.view)
            let yFocusView = (frame?.maxY)!
            let heightScreen = view.frame.height
            print("\(yFocusView)")
            print("\(heightScreen - heightKeyboard)")
            if yFocusView > heightScreen - heightKeyboard - 70 {
                UIView.animate(withDuration: 0.2) {
                    self.scrollView.contentOffset.y += (yFocusView - (heightScreen - heightKeyboard - 70))
                }
            }
            print("\(scrollView.contentOffset)")
        }
    }
    
    override func keyboardWillHide(notification: NSNotification) {
        spaceBottomCT.constant = oldConstraint
    }
    
}


extension RegisterPageThreeViewController: MyGalleryViewControllerDegelate {
    func myGalleryViewController( didSelect image: Image) {
        imgChoosing?.g_loadImage(image.asset, isMaxSize: true)
        if isChangePortrait {
            imagePortraitCam.isHidden = true
        } else {
            imagePassportCam.isHidden = true
        }
    }
    
    func myGalleryViewController(takePhoto image: UIImage) {
        imgChoosing?.image = image
        if isChangePortrait {
            imagePortraitCam.isHidden = true
        } else {
            imagePassportCam.isHidden = true
        }
    }
}
