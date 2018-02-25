//
//  User.swift
//  Stellar_iOS
//
//  Created by khpark on 2018. 2. 25..
//  Copyright © 2018년 AnotherCompany. All rights reserved.
//

import Mapper

class User: NSObject, Mappable {
    
    let id : Int
    let email : String
    let isBan : Bool
    
    required init(map: Mapper) throws {
        try id = map.from("id")
        try email = map.from("email")
        try isBan = map.from("is_ban")
    }
    
}
