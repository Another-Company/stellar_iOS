//
//  AuthAPI.swift
//  Stellar_iOS
//
//  Created by khpark on 2018. 2. 25..
//  Copyright © 2018년 AnotherCompany. All rights reserved.
//

import Moya

public enum AuthAPI {
    case login(params : [String : Any])
}

extension AuthAPI : TargetType, AccessTokenAuthorizable {
    public var baseURL : URL {
        return URL(string: Constants.BASE_URL)!
    }
    
    public var path : String {
        switch self {
        case .login:
            return "/api/users/"
        }
    }
    
    public var method : Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }
    
    public var parameters : [String : Any]? {
        switch self {
        case .login(let params):
            return params
        }
    }
    
    public var parameterEncoding : ParameterEncoding {
        return URLEncoding.default
    }
    
    public var task : Task {
        switch self {
        case .login:
            // parameter 있는 요청
            return .requestParameters(parameters: parameters!, encoding: parameterEncoding)
        default:
            // parameter 없는 요청
            return .requestPlain
        }
    }
    
    public var validate: Bool {
        return false
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var headers: [String: String]? {
        switch self {
        case .login:
            // post, patch, put requests
            return ["Content-type":"application/x-www-form-urlencoded"]
        default:
            return ["Content-type":"application/json"]
        }
    }
    
    public var authorizationType: AuthorizationType {
        switch self {
        case .login:
            // requests w/o token
            return .none
        default:
            // requests w/ token
            return .bearer
        }
    }
    
}
