//
//  QNCoreService+Buckets.swift
//  ANQiNiuAPI
//
//  Created by 刘栋 on 2018/11/9.
//  Copyright © 2018 anotheren.com. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ANBaseNetwork

extension QNCoreService {
    
    public struct Buckets: DataRequestAPI {
        
        private var token: QNAccessToken
        
        public var baseURL: String {
            return "https://rs.qbox.me"
        }
        
        public var path: String {
            return "/buckets"
        }
        
        public var method: HTTPMethod {
            return .get
        }
        
        public init(token: QNAccessToken) {
            self.token = token
            self.token.path = path
        }
        
        public var headers: HTTPHeaders {
            return ["Authorization": "QBox \(token.tokenString ?? "")"]
        }
        
        public func handle(data: Data) -> Result<[String]> {
            fatalError()
        }
        
        public func handle(json: JSON) -> Result<[String]> {
            if let array = json.array {
                var buckets = [String]()
                for item in array {
                    if let bucket = item.string {
                        buckets.append(bucket)
                    }
                }
                return .success(buckets)
            } else {
                return .failure(QNError(json: json))
            }
        }
    }
}
