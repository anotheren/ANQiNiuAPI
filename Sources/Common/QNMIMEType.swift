//
//  QNMIMEType.swift
//  ANQiNiuAPI
//
//  Created by 刘栋 on 2018/12/27.
//  Copyright © 2018 anotheren.com. All rights reserved.
//

import Foundation

public enum QNMIMEType: String {
    
    case png = "image/png"
    case jpeg = "image/jpeg"
    case log = "text/plain"
    
    public var filenameExtension: String {
        switch self {
        case .png:
            return ".png"
        case .jpeg:
            return ".jpg"
        case .log:
            return ".log"
        }
    }
}
