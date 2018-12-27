//
//  QNServiveAPITests.swift
//  QiNiuAPITests
//
//  Created by 刘栋 on 2018/11/9.
//  Copyright © 2018 anotheren.com. All rights reserved.
//

import XCTest
import ANBaseNetwork
@testable import ANQiNiuAPI

class QNServiveAPITests: XCTestCase {
    
    let accessKey = "UZAHfMcOx7Vb1ZudwDZdmMCXF_TKcvq0pcF9Uc6C"
    let secretKey = "ru03tvQjMCq3CIxeuffEnxB3-HrnsNXSOOf_FNkw"

    func testBuckets() {
        let expectation = XCTestExpectation(description: "Test Get Buckets")
        let token = QNAccessToken(accessKey: accessKey, secretKey: secretKey)
        let api = QNServiceAPI.Buckets(token: token)
        request(api: api) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let buckets):
                print(buckets)
            }
            expectation.fulfill()
        }
    }
}
