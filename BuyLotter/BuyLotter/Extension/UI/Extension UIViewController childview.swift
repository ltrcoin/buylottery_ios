//
//  Extension UIViewController childview.swift
//  SocialApp
//
//  Created by HieuTT on 03/08/2018.
//  Copyright © 2018 CNCVN. All rights reserved.
//

import Foundation
import UIKit
enum AnimationChildMove {
    case Bottom
    case Right
    case Left
    case Top
    case Center
    case None
    case SmallToBig
    case BigToSmall
    case ScrollTop
    case ScrollBottom
    case ScrollLeft
    case ScrollRight
}

extension UIViewController {
    
    func add(_ child: UIViewController, anime: AnimationChildMove = .Bottom, rect:CGRect? = nil, parentView:UIView? = nil) {
        
        var oldPha:CGFloat = 2
        if let _oldAlpha = child.view.backgroundColor?.cgColor.alpha {
            oldPha = _oldAlpha
        }
        
        addChildViewController(child)
        
        if parentView != nil {
            parentView?.addSubview(child.view)
        } else {
            view.addSubview(child.view)
        }
        var finalRect = view.frame
        if rect == nil {
            child.view.frame = view.frame
        } else {
            child.view.frame = rect!
            finalRect = rect!
        }
        
        if anime != .None && oldPha != 1 {
            child.view.backgroundColor = child.view.backgroundColor?.withAlphaComponent(0)
        }

        var originPoint = child.view.frame.origin
        switch anime {
            case .Bottom: child.view.frame.origin = CGPoint(x: 0, y: self.view.frame.height)
            case .Right: child.view.frame.origin = CGPoint(x: self.view.frame.width, y: child.view.frame.origin.y)
            case .Left: child.view.frame.origin = CGPoint(x: -self.view.frame.width, y: child.view.frame.origin.y)
            case .Top: child.view.frame.origin = CGPoint(x: 0, y: -self.view.frame.height)
            case .Center: break
                originPoint.x = (self.view.frame.width - child.view.frame.width) / 2
                originPoint.y = (self.view.frame.height - child.view.frame.height) / 2
            case .SmallToBig: child.view.frame.size = CGSize.zero
            case .ScrollTop: child.view.frame.size = CGSize.init(width: finalRect.width, height: 0)
            default: break
            
        }

        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: {
            child.view.frame = finalRect
        }) { (finished) in
            if oldPha <= 1 {
                UIView.animate(withDuration: 0.3, animations: {
                    child.view.backgroundColor = child.view.backgroundColor?.withAlphaComponent(oldPha)
                })
            }
            child.didMove(toParentViewController: self)
        }
    }

    func removeSelf(anime: AnimationChildMove = .Bottom, _parentView : UIView? = nil, isHiddenBackground:Bool = true) {
        guard parent != nil else {
            return
        }

        // Notify the child that it's about to be moved away from its parent
        willMove(toParentViewController: nil)


        var parentView = _parentView != nil ? _parentView : self.parent?.view
        switch anime {
            case .Right:
                parentView?.frame.origin = CGPoint(x: -self.view.frame.width, y: (parentView?.frame.origin.y)!)
                if _parentView == nil {
                    self.view.frame.origin = CGPoint(x: self.view.frame.width, y: self.view.frame.origin.y)
                }

            case .Left:
                parentView?.frame.origin = CGPoint(x: self.view.frame.width, y: (parentView?.frame.origin.y)!)
                if _parentView == nil {
                    self.view.frame.origin = CGPoint(x: -self.view.frame.width, y: self.view.frame.origin.y)
                }

            default: break
        }

        if _parentView == nil {
            self.view.backgroundColor = self.view.backgroundColor?.withAlphaComponent(0)
        }

        if !isHiddenBackground {
            self.view.backgroundColor = self.view.backgroundColor?.withAlphaComponent(1)
        }
        if anime == .None {
            self.view.removeFromSuperview()
        } else {
            // Remove the child view controller's view from its parent
            UIView.animate(withDuration: 0.25, delay: 0.0, options: .transitionCurlDown, animations: {
                switch anime {
                case .Right, .Left:
                    parentView?.frame.origin = CGPoint(x: 0, y: (parentView?.frame.origin.y)!)
                    if _parentView != nil {
                        if anime == .Right {
                            self.view.frame.origin = CGPoint(x: self.view.frame.width, y: self.view.frame.origin.y)
                        } else {
                            self.view.frame.origin = CGPoint(x: -self.view.frame.width, y: self.view.frame.origin.y)
                        }
                    }
                case .Bottom:
                    self.view.frame.origin = CGPoint(x: 0, y: self.view.frame.height)
                case .Top:
                    self.view.frame.origin = CGPoint(x: 0, y: -self.view.frame.height)
                default: break
                }
            }) { (finished) in
                self.view.removeFromSuperview()
            }

        }

        // Remove the child
        removeFromParentViewController()

    }
}

