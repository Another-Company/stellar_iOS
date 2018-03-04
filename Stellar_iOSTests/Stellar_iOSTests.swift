//
//  Stellar_iOSTests.swift
//  Stellar_iOSTests
//
//  Created by khpark on 2018. 1. 14..
//  Copyright © 2018년 AnotherCompany. All rights reserved.
//

import XCTest
@testable import Stellar_iOS

class Stellar_iOSTests: XCTestCase {
    
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
    
    func testBundleIdentifier(){
        XCTAssertEqual(Bundle.main.bundleIdentifier, "com.another.Stellar-iOS")
    }
    
}
