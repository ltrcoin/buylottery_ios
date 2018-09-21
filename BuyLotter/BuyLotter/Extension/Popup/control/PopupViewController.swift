//
//  EduTeacherAttendentNoteViewController.swift
//  EduManagerTeacherApp
//
//  Created by HieuTT on 21/08/2018.
//  Copyright © 2018 CNCVN. All rights reserved.
//

import UIKit

protocol PopupViewControllerDelegate {

    func popupSubmitTapped(content:String, completion: @escaping (Bool) -> Void)

    func popUpQuitTapped()
}

class PopupViewController: UIViewController {

    @IBOutlet weak var popupView: UIView!

    @IBOutlet weak var contentTxt: UITextView!
    
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBOutlet weak var gtHeightContentCt: NSLayoutConstraint!
    @IBOutlet weak var ltHeightContentCt: NSLayoutConstraint!
    
    var hasNewContent = false

    var currentSizePopup:CGRect!

    var delegate:PopupViewControllerDelegate?

    // In this custom initializer we can send dependencies that are needed
    // from this view controller to work properly.
    // We simply can't forget to pass data. In that case, the project won't compile
    init() {
        super.init(nibName: "PopupViewController", bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        popupView.layer.cornerRadius = 8
        
        self.view.layoutIfNeeded()

    }

    func setupContentView(placeholder:String){
        contentTxt.placeholder = placeholder
        contentTxt.delegate = self
        textViewDidChange(contentTxt)
    }

    override func viewWillAppear(_ animated: Bool) {
        currentSizePopup = popupView.frame
        self.popupView.frame = CGRect(x: self.view.frame.width / 2, y: self.view.frame.height / 2, width: 0, height: 0)
    }

    override func viewDidAppear(_ animated: Bool) {

        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.2) {
            self.popupView.frame = self.currentSizePopup
        }
        contentTxt.becomeFirstResponder()
    }


    // This will be never called, so we don't need to care
    // about its implementation.
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func submitBtnTapped(_ sender: Any) {
        print("submit")
        self.submitBtn.isUserInteractionEnabled = false
        self.submitBtn.showLoadingRight()
        if contentTxt.text != nil && contentTxt.text != "" {
            delegate?.popupSubmitTapped(content: contentTxt.text, completion: { (done) in
                if done {
                    self.quitAnime()
                }
                self.submitBtn.isUserInteractionEnabled = true
                self.submitBtn.hideLoading()
            })
        }
    }

    @IBAction func quitBtnTapped(_ sender: Any) {
        delegate?.popUpQuitTapped()
        quitAnime()
    }

    func quitAnime(){
        UIView.animate(withDuration: 0.2, animations: {
            self.popupView.frame = CGRect(x: self.view.frame.width / 2, y: self.view.frame.height / 2, width: 0, height: 0)
            self.view.backgroundColor = self.view.backgroundColor?.withAlphaComponent(0)
        }) { (done) in
            self.removeSelf(anime: .Center, _parentView: nil)
        }
    }

}
