//
//  TFYRouterFunction+OC.swift
//  TFYSwiftMessageRouter
//
//  Created by 田风有 on 2021/4/18.
//

import Foundation

@dynamicCallable
public struct TFYRouterDefaultOCFunction {
    // OBJC_EXPORT => extern c
    public typealias TFYRouterOCFunction = @convention(c) (_ input: NSDictionary) -> NSDictionary?
        
    internal var function: TFYRouterOCFunction
    
    public init?(_ function: TFYRouterOCFunction?) {
        guard let _function = function else {
            return nil
        }
        self.function = _function
    }

    @discardableResult
    public func dynamicallyCall(withKeywordArguments args: KeyValuePairs<String, Any>) -> NSDictionary? {
        var params = [String: Any]()
        args.forEach({ params[$0.key] = $0.value })
        return function(params as NSDictionary)
    }
}
