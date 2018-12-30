//
//  QNError.swift
//  ANQiNiuAPI
//
//  Created by 刘栋 on 2018/11/16.
//  Copyright © 2018 anotheren.com. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct QNError: Error {
    
    public let code: Int
    public let error: String
    
    public init(code: Int, error: String) {
        self.code = code
        self.error = error
    }
}

extension QNError {
    
    init(json: JSON) {
        let code = json["code"].int ?? -999
        let error = json["error"].string ?? "Unknown Error"
        self.init(code: code, error: error)
    }
}
