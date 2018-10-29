//
//  RegisterPageTwoViewController.swift
//  BuyLotter
//
//  Created by Hieu Tran on 2018/9/17.
//  Copyright © 2018 kazy. All rights reserved.
//

import UIKit

class RegisterPageTwoViewController: UIViewController {

    var model = RegisterModel()
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var inputAreaView: UIView!
    
    @IBOutlet weak var fullNameTxt: UITextField!
    
    @IBOutlet weak var dobTxt: UITextField!
    
    @IBOutlet weak var genderBtn: UIButton!
    
    @IBOutlet weak var genderLbl: UILabel!
    
    @IBOutlet weak var countryLbl: UILabel!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var genderView: UIView!
    
    @IBOutlet weak var countryView: UIView!
    
    @IBOutlet weak var spaceBottomCT: NSLayoutConstraint!
    
    @IBOutlet weak var spaceGenderCT: NSLayoutConstraint!
    
    var viewFocus:UIView?
    
    let datePicker = UIDatePicker()
    
    var sexInput = -1
    var countryInput = -1
    
    var oldConstraint:CGFloat = 0
    var oldSpaceGenderCT:CGFloat = 0
    
    var isShowPickGender = false
    var pickGenderVC:PickGenderViewController!
    
    
    var fnStr = ""
    var dobStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTxtDelegate()
        
        datePicker.datePickerMode = .date
        dobTxt.inputView = datePicker
        datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
    }
    
    @objc func dateChange(){
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        dobTxt.text = dateFormater.string(from: datePicker.date)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addKeyboardEvent()
        oldConstraint = spaceBottomCT.constant
        oldSpaceGenderCT = spaceGenderCT.constant
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeKeyboardEvent()
    }
    @IBAction func dismissKeyboardTapped(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func nextBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: "next", sender: nil)
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupView(){
        inputAreaView.layer.borderWidth = 1
        inputAreaView.layer.cornerRadius = 8
        inputAreaView.layer.borderColor =  UIColor.init(red: 158/255, green: 175/255, blue: 174/255, alpha: 1).cgColor
        
        genderView.layer.cornerRadius = 5
        countryView.layer.cornerRadius = 5
        
        genderView.layer.borderWidth = 1
        countryView.layer.borderWidth = 1
        
        genderView.layer.borderColor =  UIColor.init(red: 235/255, green: 235/255, blue: 235/255, alpha: 1).cgColor
        countryView.layer.borderColor =  UIColor.init(red: 235/255, green: 235/255, blue: 235/255, alpha: 1).cgColor
        
        nextBtn.layer.cornerRadius = 5
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
        var oldValue = ""
        if countryLbl.text != "-- Select country --" {
            oldValue = countryLbl.text!
        }
        
        let pickCountryVC = PickCountryViewController.init("")
        pickCountryVC.delegate = self
        self.add(pickCountryVC, anime: .Bottom, rect: nil)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next"
        {
            if let destinationVC = segue.destination as? RegisterPageThreeViewController {
                destinationVC.model = model
                destinationVC.model.fullname = fullNameTxt.text!
                destinationVC.model.dob = dobTxt.text!
                destinationVC.model.sex = sexInput
                destinationVC.model.country = countryInput
            }
        }
    }
}

extension RegisterPageTwoViewController: PickCountryDelegate, PickGenderDelegate{
    func changePickCountry(_ str: String, index: Int) {
        self.countryLbl.text = str
        self.countryInput = index
        
        nextBtn.setTitle("Next", for: .normal)
    }
    
    func exitPopup() {
        
    }
    
    func changePickGender(_ str: String, index: Int) {
        self.genderLbl.text = str
        self.sexInput = index
        isShowPickGender = false
        
        nextBtn.setTitle("Next", for: .normal)
        
        spaceGenderCT.constant =  oldSpaceGenderCT
        
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
}

extension RegisterPageTwoViewController: UITextFieldDelegate {
    
    
    func setupTxtDelegate(){
        fullNameTxt.delegate = self
        dobTxt.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if let text = textField.text, let textRange = Range(range, in: text) {
            if textField == fullNameTxt {
                fnStr = text.replacingCharacters(in:textRange,with:string)
            }
            if textField == dobTxt {
                dobStr = text.replacingCharacters(in:textRange,with:string)
            }
            if fnStr != "" || dobStr != "" || sexInput != -1 || countryInput != -1 {
                nextBtn.setTitle("Next", for: .normal)
            } else {
                nextBtn.setTitle("Skip", for: .normal)
            }
        }
        return true
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("\(textField.frame.maxY)")
        viewFocus = textField
        return true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField)
        return true
    }
    
}
