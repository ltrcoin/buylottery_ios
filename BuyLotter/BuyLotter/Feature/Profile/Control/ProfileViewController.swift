//
//  ProfileViewController.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/10/25.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITextFieldDelegate {
    var menuSide:MenuSideInterface!
    var data:Dictionary<String, Any> = [:]
    
    @IBOutlet weak var inputAreaView: UIView!
    
    var focusTxt:UITextField!
    
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var fullnameLbl: UILabel!
    @IBOutlet weak var fullnameTxt: UITextField!
    
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var phoneTxt: UITextField!
    
    @IBOutlet weak var btcWalletLbl: UILabel!
    @IBOutlet weak var btnWalletTxt: UITextField!
    
    @IBOutlet weak var ltrWalletLbl: UILabel!
    @IBOutlet weak var ltrWalletTxt: UITextField!
    
    @IBOutlet weak var dobLbl: UILabel!
    @IBOutlet weak var dobTxt: UITextField!
    
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var genderView: UIView!
    @IBOutlet weak var genderContentLbl: UILabel!
    
    @IBOutlet weak var countryLbl: UILabel!
    
    @IBOutlet weak var countryContentLbl: UILabel!
    @IBOutlet weak var countryView: UIView!
    
    
    @IBOutlet weak var addressLbl: UILabel!
    
    @IBOutlet weak var addressTxt: UITextField!
    
    @IBOutlet weak var portraitImg: UIImageView!
    
    @IBOutlet weak var imagePortraitCam: UIImageView!
    
    @IBOutlet weak var passportImg: UIImageView!
    
    @IBOutlet weak var imagePassportCam: UIImageView!
    
    
    @IBOutlet weak var backImg: UIImageView!

    @IBOutlet weak var spaceGenderCT: NSLayoutConstraint!
    
    @IBOutlet weak var bottomCt: NSLayoutConstraint!
    
    @IBOutlet weak var updateBtn: UIButton!
    
    let datePicker = UIDatePicker()
    
    var sexInput = -1
    var countryInput = -1
    
    var oldConstraint:CGFloat = 0
    var oldSpaceGenderCT:CGFloat = 0
    
    var isShowPickGender = false
    var pickGenderVC:PickGenderViewController!
    
    var imgChoosing:UIImageView?
    var isChangePortrait = false
    
    var fnStr = ""
    var dobStr = ""
    
    init() {
        super.init(nibName: "ProfileViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backImg.image = UIImage.init(named: "menu")?.withRenderingMode(.alwaysTemplate)
        backImg.tintColor = .white
        
        fullnameTxt.delegate = self
        phoneTxt.delegate = self
        btnWalletTxt.delegate = self
        dobTxt.delegate = self
        addressTxt.delegate = self
        
        datePicker.datePickerMode = .date
        dobTxt.inputView = datePicker
        datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        
        oldSpaceGenderCT = spaceGenderCT.constant
        
        genderView.layer.cornerRadius = 5
        countryView.layer.cornerRadius = 5
        
        genderView.layer.borderWidth = 1
        countryView.layer.borderWidth = 1
        
        genderView.layer.borderColor =  UIColor.init(red: 235/255, green: 235/255, blue: 235/255, alpha: 1).cgColor
        countryView.layer.borderColor =  UIColor.init(red: 235/255, green: 235/255, blue: 235/255, alpha: 1).cgColor
        
    }
    
    @objc func dateChange(){
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        dobTxt.text = dateFormater.string(from: datePicker.date)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addKeyboardEvent()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeKeyboardEvent()
    }
    
    func updateViewWithData(){
        if USER_DATA != nil {
            data = USER_DATA
            if let email = USER_DATA["email"] as? String {
                emailTxt.text = "\(email)"
            }
            
            if let fullname = USER_DATA["fullname"] as? String {
                fullnameTxt.text = "\(fullname)"
            }
            
            if let tel = USER_DATA["tel"] as? String {
                phoneTxt.text = "\(tel)"
            }
            
            if let wallet_btc = USER_DATA["wallet_btc"] as? String {
                btnWalletTxt.text = "\(wallet_btc)"
            }
            
            if let wallet_ltr = USER_DATA["wallet_ltr"] as? String {
                ltrWalletTxt.text = "\(wallet_ltr)"
            }
            
            if let dob = USER_DATA["dob"] as? String {
                dobTxt.text = "\(dob)"
            }
            
            if let sex = USER_DATA["sex"] as? Int, sex > 0 {
                switch sex {
                case 1:
                    genderContentLbl.text = "Male"
                case 2:
                    genderContentLbl.text = "Female"
                default:
                    genderContentLbl.text = "Other"
                }
            }
            
            if let country = USER_DATA["country"] as? Int, country > 0 ,  country < CountryConfig.data.count {
                countryContentLbl.text = "\(CountryConfig.data[country - 1])"
            }
            
            if let address = USER_DATA["address"] as? String {
                addressTxt.text = "\(address)"
            }
            
            if let linkPortrait = USER_DATA["portraitimage"] as? String {
                portraitImg.setAvatarIcon(urlStr: Config.BUCKET_LINK+linkPortrait)
                imagePortraitCam.isHidden = true
            }
            
            if let linkPassport = USER_DATA["passportimage"] as? String {
                passportImg.setAvatarIcon(urlStr: Config.BUCKET_LINK+linkPassport)
                imagePassportCam.isHidden = true
            }
        }
    }
    
    @IBAction func dismissKeyboardBtnTapped(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func genderBtnTapped(_ sender: Any) {
        if isShowPickGender {
            isShowPickGender = false
            pickGenderVC.removeSelf(anime: .Center, _parentView: nil)
            spaceGenderCT.constant =  oldSpaceGenderCT
            
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            }
            
        } else {
            isShowPickGender = true
            let frame = genderView?.superview?.convert((genderView?.frame)!, to: self.genderView.superview)
            let y = (frame?.maxY)!
            let x = (frame?.minX)!
            
            print("gender frame:\(frame)")
            pickGenderVC = PickGenderViewController.init(self)
            pickGenderVC.view.layer.cornerRadius = 5
            
            self.add(pickGenderVC, anime: .ScrollTop, rect: CGRect.init(x: x, y: y , width: genderView.frame.width, height: dobTxt.frame.height * 3), parentView: inputAreaView)
            spaceGenderCT.constant = genderView.frame.height * 3 + oldSpaceGenderCT
            
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func countryBtnTapped(_ sender: Any) {
        let pickCountryVC = PickCountryViewController.init("")
        pickCountryVC.delegate = self
        self.add(pickCountryVC, anime: .Bottom, rect: nil)
    }
    
    @IBAction func menuSideBtnTapped(_ sender: Any) {
        menuSide.toggleMenuSide()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        focusTxt = textField
        
        print("🤗 \(focusTxt.frame)")
        return true
    }
    
    override func keyboardWillShow(heightKeyboard: CGFloat) {
        
        bottomCt.constant = heightKeyboard
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    override func keyboardWillHide(notification: NSNotification) {
        bottomCt.constant = 0
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    func collectData(){
        
        data["fullname"] = fullnameTxt.text
        data["tel"] = phoneTxt.text
        
        data["wallet_btc"] = btnWalletTxt.text
        data["wallet_ltr"] = ltrWalletTxt.text
     
        data["dob"] = dobTxt.text
        data["sex"] = sexInput
        
        data["country"] = countryInput
        data["address"] = addressTxt.text
        
    }
    
    @IBAction func updateBtnTapped(_ sender: Any) {
        collectData()
        
        updateBtn.isUserInteractionEnabled = false
        updateBtn.backgroundColor = UIColor.lightGray
        updateBtn.setTitle("Updating", for: .normal)
        
        if let username = UserDefaults.standard.string(forKey: "user-email"), let pwd = UserDefaults.standard.string(forKey: "user-pwd") {
            ProfileService.init().update(email: username, pwd: pwd, data: data, portraitImg: portraitImg.image, passportImg: passportImg.image) { [weak self] (done, msg, data) in
                if done {
                    USER_DATA = data
                }
                self?.updateBtn.isUserInteractionEnabled = true
                self?.updateBtn.backgroundColor = UIColor.orange
                self?.updateBtn.setTitle("Update", for: .normal)
            }
        }
        
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
    
}

extension ProfileViewController: PickCountryDelegate, PickGenderDelegate {
    
    func changePickCountry(_ str: String, index: Int) {
        self.countryContentLbl.text = str
        self.countryInput = index
    }
    
    func exitPopup() {
        
    }
    
    func changePickGender(_ str: String, index: Int) {
        self.genderContentLbl.text = str
        self.sexInput = index
        isShowPickGender = false
        
        spaceGenderCT.constant =  oldSpaceGenderCT
        
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
}



extension ProfileViewController: MyGalleryViewControllerDegelate {
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
