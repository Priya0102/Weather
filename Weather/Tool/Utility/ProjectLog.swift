//
//  ProjectLog.swift
//  Weather
//
//  Created by Priya Gongal on 27/02/21.
//

import Foundation

public func plog<T>(_ object: @autoclosure () -> T,
                    _ file: String = #file,
                    _ function: String = #function,
                    _ line: Int = #line) {
    #if DEBUG
    let value = object()
    let fileURL = URL(fileURLWithPath: file)
    let checkThread  = Thread.isMainThread ? "UI" : "BG"
    print("**************************************************")
    print("<\(checkThread)> \(fileURL) \(function)[\(line)]: \n" + String(reflecting: value))
    print("**************************************************")
    #endif
}
