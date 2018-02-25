//
//  AuthManager.swift
//  Stellar_iOS
//
//  Created by khpark on 2018. 2. 25..
//  Copyright © 2018년 AnotherCompany. All rights reserved.
//

import Moya
import RxSwift
import Moya_ModelMapper

class AuthManager: NSObject {
    
    var providerWithoutToken : MoyaProvider<AuthAPI>!
    // var provider : MoyaProvider<AuthAPI>!
    
    override init(){
        let logger = NetworkLoggerPlugin(verbose:true)
        providerWithoutToken = MoyaProvider<AuthAPI>(plugins : [logger])
    }
    
    func login(params : Observable<[String : Any]>) -> Observable<User> {
        return params.flatMap({ (p) -> Observable<User> in
            return self.providerWithoutToken.rx.request(AuthAPI.login(params: p)).map(to: User.self).asObservable()
        })
    }
    
    
    
}
