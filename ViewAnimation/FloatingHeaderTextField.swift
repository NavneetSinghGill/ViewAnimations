//
//  FloatingHeaderTextField.swift
//  ViewAnimation
//
//  Created by Navneet on 12/25/17.
//  Copyright © 2017 Navneet. All rights reserved.
//

import UIKit

class FloatingHeaderTextField: UITextField {
    
    @IBInspectable
    open var activeColor: UIColor = .cyan {
        didSet {
            if isActive {
                setActiveState()
            }
        }
    }
    
    @IBInspectable
    open var inActiveColor: UIColor = .gray {
        didSet {
            if !isActive {
                setInActiveState()
            }
        }
    }
    
    open var placeholderFontScale: CGFloat = 0.7
    
    open var isActive: Bool = false {
        didSet {
            isActive ? setActiveState() : setInActiveStateIfShould()
        }
    }
    
    open var interchangeLeftAndRightViews: Bool = false {
        didSet {
            let tempView = leftView
            let tempViewMode = leftViewMode
            leftView = rightView
            leftViewMode = rightViewMode
            rightView = tempView
            rightViewMode = tempViewMode
        }
    }
    
    var placeholderLabel = UILabel()
    var underLineLayer: CAShapeLayer!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        refreshUnderLineLayerFrame()
    }
    
    func refreshUnderLineLayerFrame() {
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: bounds.size.height))
        path.addLine(to: CGPoint(x: bounds.size.width, y: bounds.size.height))
        
        underLineLayer.path = path.cgPath
    }
    
    func setup() {
        leftViewMode = .always
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        
        let rightContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 30))
        
        let encryptionButton = UIButton(frame: CGRect(x: 2, y: 0, width: 28, height: 30))
        encryptionButton.addTarget(self, action: #selector(self.encryptionButtonTapped(button:)), for: .touchUpInside)
        encryptionButton.setImage(UIImage(named: "openEye"), for: .normal)
        encryptionButton.setImage(UIImage(named: "closedEye"), for: .selected)
        encryptionButton.backgroundColor = UIColor.clear
        
        let leftDividerView = UIView(frame: CGRect(x: 0, y: 2, width: 1, height: encryptionButton.frame.size.height-4))
        leftDividerView.backgroundColor = UIColor.lightGray
        
        rightContainerView.addSubview(leftDividerView)
        rightContainerView.addSubview(encryptionButton)
        
        rightViewMode = .always
        rightView = rightContainerView
        
        underLineLayer = CAShapeLayer()
        refreshUnderLineLayerFrame()
        self.layer.addSublayer(underLineLayer)
        
        placeholderLabel = UILabel()
        if !(self.text?.isEmpty)! {
            isActive = true
            placeholderLabel.text = placeholder
            textFieldDidBeginEditing()
        } else {
            isActive = false
        }
        
        addSubview(placeholderLabel)
    }
    
    @objc func encryptionButtonTapped(button: UIButton) {
        self.isSecureTextEntry = !self.isSecureTextEntry
        button.isSelected = self.isSecureTextEntry
    }
    
    override open func drawPlaceholder(in rect: CGRect) {
        super.drawPlaceholder(in: rect)
        placeholderLabel.text = placeholder
        placeholder = nil
    }
    
    override open func willMove(toSuperview newSuperview: UIView?) {
        if newSuperview != nil {
            NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidEndEditing), name: Notification.Name.UITextFieldTextDidEndEditing, object: self)
            NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidBeginEditing), name: NSNotification.Name.UITextFieldTextDidBeginEditing, object: self)
        } else {
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    @objc func textFieldDidBeginEditing() {
        
        UIView.animate(withDuration: 0.25) {
            self.isActive = true
        }
    }
    
    @objc func textFieldDidEndEditing() {
        let isNotEmpty = text?.characters.isEmpty ?? true
        
        if isNotEmpty {
            
            UIView.animate(withDuration: 0.25, animations: {
                self.isActive = false
            })
        }
    }
    
    func setInActiveState()  {
        underLineLayer.fillColor = UIColor.clear.cgColor
        underLineLayer.strokeColor = inActiveColor.cgColor
        placeholderLabel.textColor = inActiveColor
        
        self.placeholderLabel.transform = CGAffineTransform.identity
        self.placeholderLabel.frame = CGRect(x: 13, y: 0, width: self.bounds.width - 10, height: self.bounds.height)
    }
    
    func setActiveState() {
        underLineLayer.fillColor = UIColor.clear.cgColor
        underLineLayer.strokeColor = activeColor.cgColor
        placeholderLabel.textColor = activeColor
        
        self.placeholderLabel.frame = CGRect(x: 13, y: -20, width: self.bounds.size.width - 20, height: 44)
        self.placeholderLabel.transform = CGAffineTransform(scaleX: self.placeholderFontScale, y: self.placeholderFontScale)
        self.placeholderLabel.frame.origin = CGPoint(x: 13, y: self.placeholderLabel.frame.origin.y)
    }
    
    func setInActiveStateIfShould() {
        if (self.text?.isEmpty)! {
            self.setInActiveState()
        }
    }
    
}
