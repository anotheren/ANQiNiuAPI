//
//  QNObjectAPI+FormUpload.swift
//  ANQiNiuAPITests
//
//  Created by 刘栋 on 2018/12/27.
//  Copyright © 2018 anotheren.com. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ANBaseNetwork
import CryptoSwift

extension QNObjectAPI {
    
    /// https://developer.qiniu.com/kodo/manual/1272/form-upload
    public struct FormUpload: JSONUploadAPI {
        
        public let tokenString: String
        public let imageData: Data
        public let fileName: String
        public let fileType: QNMIMEType
        
        public init(tokenString: String, imageData: Data, fileName: String, fileType: QNMIMEType) {
            self.tokenString = tokenString
            self.imageData = imageData
            self.fileName = fileName
            self.fileType = fileType
        }
        
        public var baseURL: String {
            return "https://upload.qiniup.com"
        }
        
        public var path: String {
            return "/"
        }
        
        public var method: HTTPMethod {
            return .post
        }
        
        public var parameters: [String: String] {
            let crc32 = UInt32(data: imageData.crc32().reversed())
            var parameters = [String: String]()
            parameters["key"] = fileName
            parameters["token"] = tokenString
            parameters["crc32"] = crc32.description
            return parameters
        }
        
        public func handle(fromData: MultipartFormData) {
            for (key, value) in parameters {
                if let encodedValue = value.data(using: .utf8) {
                    fromData.append(encodedValue, withName: key)
                }
            }
            fromData.append(imageData, withName: "file", fileName: fileName, mimeType: fileType.rawValue)
        }
        
        public func handle(json: JSON) -> Result<QNUploadResult> {
            if let uploadResult = QNUploadResult(json: json) {
                return .success(uploadResult)
            } else {
                let error = QNError(json: json)
                return .failure(error)
            }
        }
    }
}
