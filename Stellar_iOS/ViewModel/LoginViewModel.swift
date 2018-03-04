//
//  LoginViewModel.swift
//  Stellar_iOS
//
//  Created by khpark on 2018. 1. 21..
//  Copyright © 2018년 AnotherCompany. All rights reserved.
//

import Foundation
import RxSwift

class LoginViewModel : NSObject {
    fileprivate let manager = AuthManager()
    
    func login(params : [String : Any]) -> Observable<User>{
        return manager.login(params: Observable.just(params))
    }
    
}
