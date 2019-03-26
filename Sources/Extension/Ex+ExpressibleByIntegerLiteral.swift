//
//  Ex+ExpressibleByIntegerLiteral.swift
//  ANQiNiuAPI
//
//  Created by 刘栋 on 2018/12/27.
//  Copyright © 2018 anotheren.com. All rights reserved.
//

import Foundation

extension ExpressibleByIntegerLiteral {
    
    var data: Data {
        var value: Self = self
        let size: Int = MemoryLayout<Self>.size
        return withUnsafeMutablePointer(to: &value) {
            $0.withMemoryRebound(to: UInt8.self, capacity: size) {
                Data(UnsafeBufferPointer(start: $0, count: size))
            }
        }
    }
    
    init(data: Data) {
        let diff: Int = MemoryLayout<Self>.size - data.count
        if diff > 0 {
            let buffer = Data(repeating: 0, count: diff)
            self = (data+buffer).withUnsafeBytes { $0.load(as: Self.self) }
        } else if diff < 0 {
            self = data[0..<data.count+diff].withUnsafeBytes { $0.load(as: Self.self) }
        } else {
            self = data.withUnsafeBytes { $0.load(as: Self.self) }
        }
    }
}

extension ExpressibleByIntegerLiteral {
    
    init(data: ReversedCollection<Data>) {
        self.init(data: Data(data))
    }
}
