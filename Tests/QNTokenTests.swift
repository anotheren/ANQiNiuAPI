//
//  QNTokenTests.swift
//  QiNiuAPITests
//
//  Created by 刘栋 on 2018/9/3.
//  Copyright © 2018年 anotheren.com. All rights reserved.
//

import XCTest
@testable import ANQiNiuAPI

class QNTokenTests: XCTestCase {
    
    func testUploadTokenInit() {
        let accessKey = "V7yBZ89ImFbB1xeiHMEs0PtxqmgikVilc1hpuLpQ"
        let secretKey = "D0IrrqfEZfbSrwvnhQ1iGUMqMWiQdXwzVnIG0HoW"
        let bucket = "scope"
        guard let token1 = QNUploadToken(accessKey: accessKey, secretKey: secretKey, bucket: bucket, expired: 600) else {
            XCTAssert(false, "Can't init token from given data!")
            return
        }
        
        guard let token2 = QNUploadToken(parse: token1.tokenString) else {
            XCTAssert(false, "Can't init token from given token string!")
            return
        }
        
        XCTAssert(token1 == token2, "Find error when checking token!")
    }
    
    func testUploadTokenExpire() {
        let accessKey = "V7yBZ89ImFbB1xeiHMEs0PtxqmgikVilc1hpuLpQ"
        let secretKey = "D0IrrqfEZfbSrwvnhQ1iGUMqMWiQdXwzVnIG0HoW"
        let bucket = "scope"
        let expectation = XCTestExpectation(description: "测试 Token 过期")
        guard let token = QNUploadToken(accessKey: accessKey, secretKey: secretKey, bucket: bucket, expired: 2) else {
            XCTAssert(false, "Can't init token from given data!")
            return
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
            XCTAssert(!token.isExpired, "Token shound not expired")
            XCTAssert(token.expired(in: 2.1), "Token shound expired")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3)
    }
    
    func testAccessToken() {
        let accessKey = "MY_ACCESS_KEY"
        let secretKey = "MY_SECRET_KEY"
        let path = "/move/bmV3ZG9jczpmaW5kX21hbi50eHQ=/bmV3ZG9jczpmaW5kLm1hbi50eHQ="
        var token = QNAccessToken(accessKey: accessKey, secretKey: secretKey)
        token.path = path
        let string = "MY_ACCESS_KEY:FXsYh0wKHYPEsIAgdPD9OfjkeEM="
        XCTAssert(token.tokenString == string, "AccessToken is not equal!")
    }
}
