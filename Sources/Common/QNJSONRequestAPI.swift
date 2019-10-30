//
//  QNJSONRequestAPI.swift
//  ANQiNiuAPI
//
//  Created by 刘栋 on 2019/1/10.
//  Copyright © 2019 anotheren.com. All rights reserved.
//

import Foundation
import ANBaseNetwork
import SwiftyJSON
import Alamofire

public protocol QNJSONRequestAPI: DataRequestAPI {
    
    func handle(json: JSON) -> Result<ResultType, Error>
}

extension QNJSONRequestAPI {
    
    public func handle(data: Data) -> Result<ResultType, Error> {
        do {
            let json = try JSON(data: data)
            return handle(json: json)
        } catch {
            return .failure(error)
        }
    }
}
