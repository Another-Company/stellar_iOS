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
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {

    // MARK: - constants
    let disposeBag = DisposeBag()
    
    // MARK: - variables
    @IBOutlet weak var fbloginBtn: UIButton!
    @IBOutlet weak var googleLoginBtn: UIButton!
    @IBOutlet weak var kakaoLoginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        setupViews()
        setupRx()
        
    }
    
    fileprivate func setupViews(){
        
    }
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        if error != nil {
            print("error")
        }
        print("signininwilldispatch",signIn)
    }
    

    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
        print("signinpresent",signIn)
    }
    
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
        print("dismiss",signIn)
    }
    
    
    fileprivate func setupRx(){
        //페이스북로그인
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
        
        
        
        // 구글 로그인
        googleLoginBtn.rx.tap.debounce(0.1, scheduler: MainScheduler.instance).subscribe { (event) in
            print("google")
            
            GIDSignIn.sharedInstance().delegate = self
            GIDSignIn.sharedInstance().uiDelegate = self
            GIDSignIn.sharedInstance().signIn()
            
            
            
        }.disposed(by: disposeBag)
//      구글로그인(커스텀 버튼 클래스사용시?)
//        let tap = UIGestureRecognizer()
//        tap.rx.event.bind { (tap) in
//            print(1234)
//        }.disposed(by: disposeBag)
//        googleLoginBtn.addGestureRecognizer(tap)

        
        kakaoLoginBtn.rx.tap.debounce(0.1, scheduler: MainScheduler.instance).subscribe { (event) in
            let session : KOSession = KOSession.shared()
            
            if session.isOpen() {
                session.close()
            }
            
            session.open(completionHandler: { (error) in
                if !session.isOpen() {
                    if let e = error {
                        let nserror = e as NSError
                        switch nserror.code {
                        case Int(KOErrorCancelled.rawValue):
                            break
                        default:
                            let alert = UIAlertController(title: "에러", message: error?.localizedDescription, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                } else {
                    print("kakao login success")
                }
            }, authTypes: [NSNumber(value: KOAuthType.talk.rawValue)])
        }.disposed(by: disposeBag)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        }
//        else {
////             Perform any operations on signed in user here.
//
//            print("user",user)
//            let userId = user.userID
//            let idToken = user.authentication.idToken
//            let fullName = user.profile.name
//            let givenName = user.profile.givenName
//            let familyName = user.profile.familyName
//            let email = user.profile.email
//            print(givenName)
//        }
            guard let authentication = user.authentication else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                           accessToken: authentication.accessToken)
            // ...
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                print(error)
                return
            }
            if let user = user {
                let uid = user?.uid
                let email = user?.email
            }
            
            
        }
    }

    
    
}
