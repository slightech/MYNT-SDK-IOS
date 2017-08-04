//
//  String.swift
//  STMyntBluetooth
//
//  Created by gejw on 2017/6/9.
//  Copyright © 2017年 robinge. All rights reserved.
//

import Foundation


public extension String {

    /// 长度
    public var length: Int {
        return characters.count
    }

    /**
     排除两侧空格

     :returns: <#return value description#>
     */
    public func trim() -> String {
        return trimmingCharacters(in: .whitespaces)
    }

    /**
     截取字符串

     - parameter range: 字符串范围

     - returns:
     */
    public func substringWithRange(start: Int, length: Int) -> String! {
        return (self as NSString).substring(with: NSRange(location:start, length: length))
    }
    
}
