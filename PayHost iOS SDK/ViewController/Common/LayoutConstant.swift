//
//  LayoutConstant.swift
//  PayHost iOS SDK
//
//  Author: PayGate (Pty) Ltd
//  Author URI: https://www.paygate.co.za/
//  Developer: App Inlet (Pty) Ltd
//  Developer URI: https://www.appinlet.com/
//
//  Copyright: © 2020 PayGate (Pty) Ltd.
//  License: GNU General Public License v3.0
//  License URI: http://www.gnu.org/licenses/gpl-3.0.html
//

import Foundation
import UIKit
import KRProgressHUD
struct SetLayout {
    func SetBorderWidth(view:UIImageView){
        view.layer.cornerRadius = view.frame.height / 2.0
        view.layer.masksToBounds = true
        view.clipsToBounds = true
    }
    func textFiledWithPlaceholderColor(textfiled:UITextField,_ placeholderString:String){
        textfiled.attributedPlaceholder = NSAttributedString(string: placeholderString,
                                                             attributes: [NSAttributedString.Key.foregroundColor: AppColor.placeholderColor])
    }
}
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
extension String {
    func isEmptyWhiteSpaces() -> Bool {
        let whitespaceSet = CharacterSet.whitespaces
        return self.trimmingCharacters(in: whitespaceSet).isEmpty
    }
    
}
extension UIImageView {
    func setRadius(radius: CGFloat? = nil) {
        self.layer.cornerRadius = radius ?? self.frame.width / 2;
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0.5
        self.layer.masksToBounds = true;
    }
}
extension UIButton {
    func setRadiusbutton(radius: CGFloat? = nil) {
        self.layer.cornerRadius = radius ?? self.frame.width / 2;
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0.5
        self.layer.masksToBounds = true;
    }
}

//MARK:----------------------------Shdowview / cardView--------------------

class ShadowView: UIView {
    override var bounds: CGRect {
        didSet {
            setupShadow()
        }
    }
    
    private func setupShadow() {
        self.layer.cornerRadius = 8
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.3
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
//MARK:----------------------------Cornerradadiuos To View--------------------
class CornerView:UIView{
    override var bounds: CGRect {
        didSet {
            setupCorners()
        }
    }
    
    private func setupCorners() {
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
    }
}

class UIPlaceHolderTextView: UITextView {
    
    
    //MARK: - Properties
    @IBInspectable var placeholder: String?
    @IBInspectable var placeholderColor: UIColor?
    var placeholderLabel: UILabel?
    
    
    //MARK: - Initializers
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // Use Interface Builder User Defined Runtime Attributes to set
        // placeholder and placeholderColor in Interface Builder.
        if self.placeholder == nil {
            self.placeholder = ""
        }
        if self.placeholderColor == nil {
            self.placeholderColor = UIColor.black
        }
        NotificationCenter.default.addObserver(self, selector: #selector(textChanged(_:)), name: UITextView.textDidChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(textChanged(_:)), name: UITextView.textDidBeginEditingNotification, object: nil)
    }
    
    @objc func textChanged(_ notification: Notification) -> Void {
        if self.placeholder?.count == 0 {
            return
        }
        
        UIView.animate(withDuration: 0.25) {
            if self.text.count == 0 {
                self.viewWithTag(999)?.alpha = 1
            }
            else {
                self.viewWithTag(999)?.alpha = 0
            }
        }
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if (self.placeholder?.count ?? 0) > 0 {
            if placeholderLabel == nil {
                placeholderLabel = UILabel.init()
                placeholderLabel?.lineBreakMode = .byWordWrapping
                placeholderLabel?.numberOfLines = 0
                placeholderLabel?.font = self.font
                placeholderLabel?.backgroundColor = self.backgroundColor
                placeholderLabel?.textColor = self.placeholderColor
                placeholderLabel?.alpha = 0
                placeholderLabel?.tag = 999
                self.addSubview(placeholderLabel!)
                
                placeholderLabel?.translatesAutoresizingMaskIntoConstraints = false
                placeholderLabel?.topAnchor.constraint(equalTo: self.topAnchor, constant: 7).isActive = true
                placeholderLabel?.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 4).isActive = true
                placeholderLabel?.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
                placeholderLabel?.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            }
            
            placeholderLabel?.text = self.placeholder
            placeholderLabel?.sizeToFit()
            self.sendSubviewToBack(self.placeholderLabel!)
        }
        
        if self.text.count == 0 && (self.placeholder?.count ?? 0) > 0 {
            self.viewWithTag(999)?.alpha = 1
        }
    }
}
extension UIViewController{
    func setMenuButton(){
        // -- setup revealview (side menu) --
        if let revealController = self.revealViewController() {
            revealController.panGestureRecognizer()
            let menuButton = UIBarButtonItem(image: UIImage(named: "menu"),
                                             style: .plain, target: revealController,
                                             action: #selector(SWRevealViewController.revealToggle(_:)))
            self.navigationItem.leftBarButtonItem = menuButton
        }
        
    }
    func setTextViewShdow(_ textview:UITextView){
        textview.layer.shadowColor = UIColor.gray.cgColor;
        textview.layer.shadowOffset = CGSize(width: 1.0, height: 0.5)
        textview.layer.shadowOpacity = 1.0
        textview.layer.shadowRadius = 2.0
        textview.layer.masksToBounds = false
    }
}


