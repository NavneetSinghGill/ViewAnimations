//
//  BPAnimateViewContentExtension.swift
//  ViewAnimation
//
//  Created by Navneet on 12/21/17.
//  Copyright © 2017 Navneet. All rights reserved.
//

import UIKit

extension UIView {
    
    static let screenWidth = UIScreen.main.bounds.width
    
    private struct AnimationKeys {
        static var delayKey: UInt8 = 0
    }
    
    private var delay: Int {
        get {
            guard let value = objc_getAssociatedObject(self, &AnimationKeys.delayKey) as? Int else {
                return NSNotFound
            }
            return value
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AnimationKeys.delayKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @IBInspectable
    var BPDelay: Int {
        get {
            return self.delay
        }
        set {
            self.delay = newValue
        }
    }
    
    //MARK:- Animation methods
    
    func animateCenterToLeft() {
        for view in self.subviews {
            view.animateCenterToLeft()
            if view.BPDelay == NSNotFound {
                print("NotFound\n\n")
                continue
            } else {
                print("Found\n\n")
                UIView.animate(withDuration: 0.5,
                               delay: TimeInterval(CGFloat(view.BPDelay) * 0.25),
                               options: UIViewAnimationOptions.curveEaseInOut,
                               animations: {
                                view.frame.origin.x = self.frame.origin.x - UIView.screenWidth
                }, completion: { (completed) in
                    
                })
            }
            
        }
    }
    
}
