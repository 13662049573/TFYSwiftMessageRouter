//
//  TFYRouterSILFunction.swift
//  TFYSwiftMessageRouter
//
//  Created by 田风有 on 2021/4/18.
//

import Foundation

///Any：可以代表任意类型（枚举、结构体、类，也包括函数类型）
///AnyObject：可以代表任意类类型（在协议后面写上: AnyObject代表只有类能遵守这个协议） ü 在协议后面写上: class也代表只有类能遵守这个协议
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
    //在func前面加个@discardableResult，可以消除：函数调用后返回值未被使用的警告⚠
    @discardableResult
    public func dynamicallyCall(withKeywordArguments args: KeyValuePairs<String, Any>) -> [String: Any]? {
        var params = [String: Any]()
        args.forEach({ params[$0.key] = $0.value })
        return function(params)
    }
}
