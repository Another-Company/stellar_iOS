//
//  TokenAuth.swift
//  Stellar_iOS
//
//  Created by khpark on 2018. 3. 4..
//  Copyright © 2018년 AnotherCompany. All rights reserved.
//

import Foundation
import Security
import Alamofire

class TokenAuth {
    // MARK: - Save
    //
    func save(_ service: String, account: String, value: String) {
        let keyChainQuery: NSDictionary = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrService : service,
            kSecAttrAccount: account,
            kSecValueData : value.data(using: .utf8, allowLossyConversion: false)!]
        
        SecItemDelete(keyChainQuery)
        
        let status: OSStatus = SecItemAdd(keyChainQuery, nil)
        assert(status == noErr, "토큰 값 저장에 실패")
        NSLog("status=\(status)")
    }
    // MARK: - Load
    //
    func load(_ service: String, account: String) -> String? {
        
        let keyChainQuery: NSDictionary = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrService : service,
            kSecAttrAccount : account,
            kSecReturnData : kCFBooleanTrue,
            kSecMatchLimit : kSecMatchLimitOne]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(keyChainQuery, &dataTypeRef)
        
        if (status == errSecSuccess) {
            let retrievedData = dataTypeRef as! Data
            let value = String(data: retrievedData, encoding: String.Encoding.utf8)
            return value
        } else {
            print("실패 \(status)")
            return nil
        }
    }
    // MARK: - Delete
    //
    func delete(_ service: String, account: String) {
        let keyChainQuery : NSDictionary = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrService : service,
            kSecAttrAccount : account]
        
        let status = SecItemDelete(keyChainQuery)
        assert(status == noErr, "토큰삭제실패")
        NSLog("status=\(status)")
    }
    // MARK: - Token
    //
    func getAuthHeaders() -> HTTPHeaders? {
        let serviceID = Bundle.main.bundleIdentifier!
        if let accessToken = self.load(serviceID, account: "accessToken") {
            return ["Authorization" : "token \(accessToken)"] as HTTPHeaders
        } else {
            return nil
        }
    }
}
