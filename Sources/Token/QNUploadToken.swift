//
//  QNUploadToken.swift
//  ANQiNiuAPI
//
//  Created by 刘栋 on 2018/9/3.
//  Copyright © 2018 anotheren.com. All rights reserved.
//

import Foundation
import CryptoSwift
import SwiftyJSON

// https://developer.qiniu.com/kodo/manual/1208/upload-token
public struct QNUploadToken: Hashable, Codable {
    
    public let accessKey: String
    public let encodedSign: String
    public let encodedPutPolicy: String
    public let bucket: String
    public let expireDate: Date
    
    public var tokenString: String {
        return [accessKey, encodedSign, encodedPutPolicy].joined(separator: ":")
    }
    
    private init(accessKey: String, encodedSign: String, encodedPutPolicy: String, bucket: String, expireDate: Date) {
        self.accessKey = accessKey
        self.encodedSign = encodedSign
        self.encodedPutPolicy = encodedPutPolicy
        self.bucket = bucket
        self.expireDate = expireDate
    }
    
    private init?(accessKey: String, encodedSign: String, encodedPutPolicy: String) {
        guard let putPolicyData = Data(base64Encoded: encodedPutPolicy), let putPolicy = String(data: putPolicyData, encoding: .utf8) else {
            return nil
        }
        let json = JSON(parseJSON: putPolicy)
        guard let bucket = json["scope"].string, let deadline = json["deadline"].int else {
            return nil
        }
        let expireDate = Date(timeIntervalSince1970: TimeInterval(deadline))
        self.init(accessKey: accessKey, encodedSign: encodedSign, encodedPutPolicy: encodedPutPolicy, bucket: bucket, expireDate: expireDate)
    }
    
    public init?(parse string: String) {
        let parts = string.split(separator: ":")
        guard parts.count == 3 else {
            return nil
        }
        self.init(accessKey: String(parts[0]), encodedSign: String(parts[1]), encodedPutPolicy: String(parts[2]))
    }
    
    public init?(accessKey: String, secretKey: String, bucket: String, expired: TimeInterval) {
        let deadline = Int(Date().addingTimeInterval(expired).timeIntervalSince1970)
        let putPolicy: String =
        """
        {"scope":"\(bucket)","deadline":\(deadline)}
        """
        guard let putPolicyData = putPolicy.data(using: .utf8) else {
            return nil
        }
        let encodedPutPolicy = putPolicyData.base64EncodedString()
        let expireDate = Date(timeIntervalSince1970: TimeInterval(deadline))
        
        do {
            let sign = try HMAC(key: secretKey.bytes, variant: .sha1).authenticate(encodedPutPolicy.bytes)
            let encodedSign = Data(sign).base64EncodedString()
            self.init(accessKey: accessKey, encodedSign: encodedSign, encodedPutPolicy: encodedPutPolicy, bucket: bucket, expireDate: expireDate)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

extension QNUploadToken {
    
    public var isExpired: Bool {
        return Date() > expireDate
    }
    
    public func expired(in interval: TimeInterval) -> Bool {
        return Date() + interval > expireDate
    }
}

extension QNUploadToken: CustomStringConvertible {
    
    public var description: String {
        return "QNUploadToken(bucket=\(bucket),expireDate=\(expireDate))"
    }
}
