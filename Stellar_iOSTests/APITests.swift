//
//  APITests.swift
//  Stellar_iOSTests
//
//  Created by khpark on 2018. 2. 25..
//  Copyright © 2018년 AnotherCompany. All rights reserved.
//

import XCTest
@testable import Stellar_iOS
import RxSwift
class APITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFacebookLogin(){
        let vm = LoginViewModel()
        let promise = expectation(description: "facebook login")
        let params : [String : Any] = [
            "access_token": "EAAIL063ZAXZCkBAAi8gXwRTAv0d5TC6Q5C3ObtgSH5K6BwwXWwrIhFstb5oZAcUfKVamZAk5vekNGniiLdCqZBVyYMZBEvhot1Gl3OhD4zQKFyRe2xnFcWTvboY5uIJ0QCfeA0fbtxlChwZB78INZCYJkb3ZB0FOZAbuu19uJvMAmFysx7NlOUQZB5Qj5ZAtsc5bO8HjNtN5ahrfmeDCe5Q0EB3duq5VKA186g4zZAmZA0KtR4ujB8lP6ZCYtL8",
            "email":"ios_gsthtni_testuser@tfbnw.net",
            "email_verified":true,
            "provider":"FB",
        ]
        vm.login(params: params).subscribe(onNext: { (user) in
            print(user.id)
            promise.fulfill()
        }, onError: { (error) in
            print(error)
        }).disposed(by: DisposeBag())
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    
    
    
}
