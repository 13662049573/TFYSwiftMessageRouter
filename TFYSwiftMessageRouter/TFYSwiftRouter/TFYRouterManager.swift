//
//  TFYRouterManager.swift
//  TFYSwiftMessageRouter
//
//  Created by 田风有 on 2021/4/18.
//

import Foundation

///单例 任何地方都可以访问 open：允许在定义实体的模块、其他模块中访问，允许其他模块进行继承、重写（open只能用在类、类成员上）
open class TFYRouterManager {
    public static let `default` = TFYRouterManager()
    ///internal 只允许在定义实体的模块中访问，不允许在其他模块中访问
    internal var lock = TFYRouterLock()
    internal var cacheSymbols = [String: UnsafeRawPointer]()///UnsafePointer<Pointee> 类似于 const Pointee *
    internal var defaultNotFoundHandler: ((_ router: String)->())?
}

///类的扩展 public：允许在定义实体的模块、其他模块中访问，不允许其他模块进行继承、重写
public extension TFYRouterManager {
    
    func registeredDefultNotFoundHandler(_ handler: @escaping (_ router: String)->()) {
        self.defaultNotFoundHandler = handler
    }
}

public extension TFYRouterManager {
    
    func routeTo(_ router: String) -> TFYRouterDefaultSILFunction? {
        let function = self.routeTo(router, routerSILFunctionType: TFYRouterDefaultSILFunction.TFYRouterSILFunction.self)
        return TFYRouterDefaultSILFunction(function)
    }
    
    func routeTo<T>(_ router: String, routerSILFunctionType functionType: T.Type) -> T? {
        assert(MemoryLayout<T>.size == MemoryLayout<UnsafeRawPointer>.size, "\(T.self) is not @convention(thin) Function Type")
        
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
            let routerSymbol = TFYRouteFindSymbolAtModule(module, symbol: router) else { return nil }
        
        cacheSymbols[router] = routerSymbol
        let routerFunction = unsafeBitCast(routerSymbol, to: T.self)
        return routerFunction
    }
}

public extension TFYRouterManager {
    @discardableResult
    func routeAndHandleNotFound(_ router: String, notFoundHandle handler: (()->())? = nil) -> TFYRouterDefaultSILFunction? {
        let routerFunction = routeAndHandleNotFound(router, routerSILFunctionType: TFYRouterDefaultSILFunction.TFYRouterSILFunction.self, notFoundHandle: handler)
        return TFYRouterDefaultSILFunction(routerFunction)
    }
    
    @discardableResult
    func routeAndHandleNotFound<T>(_ router: String, routerSILFunctionType functionType: T.Type, notFoundHandle handler: (()->())? = nil) -> T? {
        if let router = routeTo(router, routerSILFunctionType: functionType) {
           return router
        }
        handler == nil ? defaultNotFoundHandler?(router):handler?()
        return nil
    }
}
