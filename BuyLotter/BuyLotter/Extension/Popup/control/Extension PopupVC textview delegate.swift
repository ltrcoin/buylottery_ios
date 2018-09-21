//
//  Extension EduTeacherAttendentNoteVC textview delegate.swift
//  EduManagerTeacherApp
//
//  Created by HieuTT on 21/08/2018.
//  Copyright © 2018 CNCVN. All rights reserved.
//

import Foundation
import UIKit
extension PopupViewController: UITextViewDelegate {
    

    func textViewDidChange(_ textView: UITextView) {
        if textView.text == "" {
            if hasNewContent {
                self.submitBtn.isUserInteractionEnabled = false
                UIView.animate(withDuration: 0.3) {
                    self.submitBtn.backgroundColor = UIColor.groupTableViewBackground
                }
                hasNewContent = false
            }

        } else if !self.hasNewContent {
            self.submitBtn.isUserInteractionEnabled = true
            self.hasNewContent = true
            UIView.animate(withDuration: 0.3) {
                self.submitBtn.backgroundColor = UIColor.init(red: 1, green: 154/255, blue: 42/255, alpha: 1)
            }
        }

        textView.updatePlaceHolderView()
        let fixedWidth = self.view.frame.size.width
        let newSize = contentTxt.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))


        if newSize.height >= ltHeightContentCt.constant && contentTxt.isScrollEnabled == false {
            gtHeightContentCt.constant = ltHeightContentCt.constant - 1
            contentTxt.isScrollEnabled = true
        } else if newSize.height < ltHeightContentCt.constant && gtHeightContentCt.constant > 100 {
            contentTxt.isScrollEnabled = false
            gtHeightContentCt.constant = newSize.height > 100 ? newSize.height : 100
        }
    }

}
