//
//  EmailViewController.swift
//  Stellar_iOS
//
//  Created by toygift on 2018. 3. 25..
//  Copyright © 2018년 AnotherCompany. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class EmailViewController: UIViewController, UITextFieldDelegate {
    
    let disposeBag = DisposeBag()
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var startButton: UIButton!
    
    @IBAction func startEmail(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTextField.delegate = self
        self.emailTextField.addBorderBottom(height: 2.0, color: UIColor.black)
        self.navigationItem.leftBarButtonItem?.title = "Sign up"
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        UIView.animate(withDuration: 0.5) {
            self.emailTextField.addBorderBottom(height: 2.0, color: self.hexStringToUIColor(hex: "#573bdf"))
        }
        
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if let email = self.emailTextField.text {
            print("guard let")
            UIView.animate(withDuration: 0.5) {
                if self.isValidEmailAddress(email: email) {
                    // 이미지 체인지
                }
            }
        }
        return true
    }
}
extension EmailViewController {
    // 텍스트 필드 컬러
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    // 이메일 정규식
    func isValidEmailAddress(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
        
    }

}
extension UITextField {
    func addBorderBottom(height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.frame.height-height, width: self.frame.width, height: height)
        border.backgroundColor = color.cgColor
        self.layer.addSublayer(border)
    }
}

//    func emailSignup() {
//        emailTextField.rx.text.bindTo(self.emailTextField).addTo(disposeBag)
//        startButton.rx.tap.debounce(0.1, schedul  er: MainScheduler.instance).subscribe { (_) in
//            print("start")
//        }
//    }
