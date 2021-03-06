//
//  EducationMySchoolLoginViewController.swift
//  CNCAPP
//
//  Created by Satacus on 06/07/2018.
//  Copyright © 2018 CNCVN. All rights reserved.
//

import UIKit
import Localize_Swift
protocol UILoginDelegate {
    func logined(data:Dictionary<String,Any>?, completion: @escaping (Bool) -> Void)
}
class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var inputAreaView: UIView!
    
    @IBOutlet weak var accountTxt: UITextField!

    @IBOutlet weak var pwdTxt: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!

    @IBOutlet weak var registerBtn: UIButton!
    
    @IBOutlet weak var notifyLbl: UILabel!
    
    var data:Dictionary<String,Any> = [:]

    var delegate: UILoginDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        Localize.resetCurrentLanguageToDefault()
        // Do any additional setup after loading the view.
        
        setText()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupView()
        setupTxtDelegate()

        addKeyboardEvent()
        
    }
    
    func setupView(){
        inputAreaView.layer.borderWidth = 1
        inputAreaView.layer.cornerRadius = 8
        inputAreaView.layer.borderColor =  UIColor.init(red: 158/255, green: 175/255, blue: 174/255, alpha: 1).cgColor
        
        loginBtn.layer.cornerRadius = 5
        registerBtn.layer.cornerRadius = 5
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: NSNotification.Name( LCLLanguageChangeNotification), object: nil)
    }


    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        removeKeyboardEvent()
    }
    
    @objc func setText(){
        loginBtn.setTitle("login".localized(using: "ButtonTitle"), for: .normal)
    }
    
    @IBAction func registerBtnTapped(_ sender: Any) {
        
        let registerVC = UIStoryboard.init(name: "Register", bundle: nil).instantiateViewController(withIdentifier: "RegisterNav")
        
        self.present(registerVC, animated: true, completion: nil)
        
    }
    

    @IBAction func loginDidTouch(_ sender: Any) {
        if accountTxt.text ==  "" || !self.loginBtn.isUserInteractionEnabled{
            return
        }
        self.loginBtn.isUserInteractionEnabled = false
        
        // làm mờ register btn
        self.registerBtn.isUserInteractionEnabled = false
        self.registerBtn.alpha = 0.5

        data["username"] = accountTxt.text!
        data["pwd"] = pwdTxt.text!

        // authentication
        /*
         */
        LoginService().login(username: accountTxt.text!, pwd: pwdTxt.text!) { [weak self] (error, msg, data) in
            if !error {
                self?.notifyLbl.isHidden = false
                self?.notifyLbl.text = msg
            } else {
                self?.notifyLbl.isHidden = true
                print(data)
                let authenVC = TwoFactorAuthenViewController.init()
                self?.present(authenVC, animated: true, completion: nil)
            }
            self?.loginBtn.isUserInteractionEnabled = true
            self?.registerBtn.isUserInteractionEnabled = true
            self?.registerBtn.alpha = 1
        }
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
