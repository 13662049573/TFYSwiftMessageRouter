//
//  TFYRouterSILFunction.swift
//  TFYSwiftMessageRouter
//
//  Created by 田风有 on 2021/4/18.
//

import Foundation

@dynamicCallable
public struct TFYRouterDefaultSILFunction {
    public typealias TFYRouterSILFunction = @convention(thin) (_ input: [String: Any]) -> [String: Any]?
        
    internal var function: TFYRouterSILFunction
    
    public init?(_ function: TFYRouterSILFunction?) {
        guard let _function = function else {
            return nil
        }
        self.function = _function
    }

    @discardableResult
    public func dynamicallyCall(withKeywordArguments args: KeyValuePairs<String, Any>) -> [String: Any]? {
        var params = [String: Any]()
        args.forEach({ params[$0.key] = $0.value })
        return function(params)
    }
}
