//
//  LoginViewController.swift
//  Stellar_iOS
//
//  Created by khpark on 2018. 1. 28..
//  Copyright © 2018년 AnotherCompany. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import FBSDKCoreKit
import FBSDKLoginKit
class LoginViewController: UIViewController {

    // MARK: - constants
    let disposeBag = DisposeBag()
    
    // MARK: - variables
    @IBOutlet weak var fbloginBtn: UIButton!
    @IBOutlet weak var googleLoginBtn: UIButton!
    @IBOutlet weak var kakaoLoginBtn: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupRx()
        
    }
    
    fileprivate func setupViews(){
        
    }
    
    fileprivate func setupRx(){
        fbloginBtn.rx.tap.debounce(0.1, scheduler: MainScheduler.instance).subscribe { (event) in
            FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self, handler: { (result, err) in
                if err != nil {
                    print(12345) // process error
                    return
                }
                
                if let cancelled = result?.isCancelled, cancelled {
                    // TODO: - process cancel
                }
                
                let accessToken = FBSDKAccessToken.current()
                guard let accessTokenString = accessToken?.tokenString else {return}
                print(accessTokenString)
                
                
            })
        }.disposed(by: disposeBag)
    }
    
    

}
