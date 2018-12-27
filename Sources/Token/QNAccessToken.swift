//
//  QNAccessToken.swift
//  ANQiNiuAPI
//
//  Created by 刘栋 on 2018/11/5.
//  Copyright © 2018 anotheren.com. All rights reserved.
//

import Foundation
import CryptoSwift

// https://developer.qiniu.com/kodo/manual/1201/access-token
public struct QNAccessToken: Hashable, Codable {
    
    public let accessKey: String
    public let secretKey: String
    public var path: String = ""
    public var body: String = ""
    
    public var tokenString: String? {
        guard let data = (path + "\n" + body).data(using: .utf8) else {
            return nil
        }
        do {
            let sign = try HMAC(key: secretKey, variant: .sha1).authenticate(data.bytes)
            let encodedSign = Data(sign).base64EncodedString()
            return [accessKey, encodedSign].joined(separator: ":")
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    public init(accessKey: String, secretKey: String) {
        self.accessKey = accessKey
        self.secretKey = secretKey
    }
}
