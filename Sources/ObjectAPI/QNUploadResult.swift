//
//  QNUploadResult.swift
//  ANQiNiuAPI
//
//  Created by 刘栋 on 2018/12/30.
//  Copyright © 2018 anotheren.com. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct QNUploadResult {
    
    public let key: String
    public let hash: String
    
    init(key: String, hash: String) {
        self.key = key
        self.hash = hash
    }
    
    init?(json: JSON) {
        guard
            let key = json["key"].string,
            let hash = json["hash"].string
            else {
                return nil
        }
        self.init(key: key, hash: hash)
    }
}
