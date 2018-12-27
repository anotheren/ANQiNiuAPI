//
//  QNError.swift
//  ANQiNiuAPI
//
//  Created by 刘栋 on 2018/11/16.
//  Copyright © 2018 anotheren.com. All rights reserved.
//

import Foundation

public struct QNError: Error {
    
    public let code: Int
    public let error: String
    
    public init(code: Int = -1, error: String = "") {
        self.code = code
        self.error = error
    }
}
