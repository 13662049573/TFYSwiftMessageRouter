//
//  TFYRouterManager+OC.swift
//  TFYSwiftMessageRouter
//
//  Created by 田风有 on 2021/4/18.
//

import Foundation
///fileprivate：只允许在定义实体的源文件中访问
public extension TFYRouterManager {
    
    func ocRouteTo(_ router: String) -> TFYRouterDefaultOCFunction? {
        let function = self.ocRouteTo(router, routerOCFunctionType: TFYRouterDefaultOCFunction.TFYRouterOCFunction.self)
        return TFYRouterDefaultOCFunction(function)
    }

    func ocRouteTo<T>(_ router: String, routerOCFunctionType functionType: T.Type) -> T? {
        assert(MemoryLayout<T>.size == MemoryLayout<UnsafeRawPointer>.size, "\(T.self) is not @convention(c) Function Type")
               
        if !isFunction(functionType) {
            TFYRouterLog(router: router, message: "\(functionType) Is Not FunctionType")
            return nil
        }
        
        lock.lock()
        defer {
            lock.unlock()
        }
        
        if let symbol = cacheSymbols[router] {
            let routerFunction = unsafeBitCast(symbol, to: T.self)
            return routerFunction
        }
        
        guard let module = router.components(separatedBy: ".").first,
            let symbol = router.components(separatedBy: ".").last,
            let routerSymbol = TFYRouteFindSymbolAtModule(module, symbol: symbol) else { return nil }
        
        cacheSymbols[router] = routerSymbol
        let routerFunction = unsafeBitCast(routerSymbol, to: T.self)
        return routerFunction
    }
}
