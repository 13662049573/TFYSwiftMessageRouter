//
//  ViewController.swift
//  TFYSwiftMessageRouter
//
//  Created by 田风有 on 2021/4/17.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "TFYSwiftMessageRouter"
        view.backgroundColor = .white
        
        TFYRouterManager.openLog()
        
        TFYRouterManager.default.registeredDefultNotFoundHandler { router in
            Log("\(router) Erroe:404")
        }
        
        TFYRouterManager.default.routeAndHandleNotFound("TFYSwiftMessageRouter.404-Test")
        
        let button = UIButton(frame: CGRect(x:0, y:200, width:kScreenW, height: 60))
        button.setTitle("pop", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .orange
        button.addTarget(self, action: #selector(Rootpush), for: .touchUpInside)
        view.addSubview(button)
        
        
        let button2 = UIButton(frame: CGRect(x:0, y:300, width:kScreenW, height: 60))
        button2.setTitle("action", for: .normal)
        button2.setTitleColor(.systemBlue, for: .normal)
        button2.backgroundColor = .red
        button2.addTarget(self, action: #selector(action), for: .touchUpInside)
        view.addSubview(button2)
    }
    
    @objc func Rootpush() {
        TFYRouterManager.default.routeTo("TFYSwiftMessageRouter.root")?(navi:self.navigationController as Any,title:"测试数据")
    }
    
    @objc func action() {
        
        TFYRouterManager.default.routeTo("TFYSwiftMessageRouter.loginActionTestDefault(Swift.Dictionary<Swift.String, Any>) -> Swift.Optional<Swift.Dictionary<Swift.String, Any>>")?(param1: "hello", param2: 996)
        
        if let action = TFYRouterManager.default.routeTo("TFYSwiftMessageRouter.LoginActionTest1() -> ()", routerSILFunctionType: (@convention(thin) ()->()).self) {
            action()
        }
        
        if let action2 = TFYRouterManager.default.routeTo("TFYSwiftMessageRouter.LoginActionTest2(Swift.Int) -> ()", routerSILFunctionType: (@convention(thin) (Int)->()).self) {
            action2(2)
        }
        
        if let action3 = TFYRouterManager.default.routeTo("TFYSwiftMessageRouter.LoginActionTest3(a: Swift.Int) -> ()", routerSILFunctionType: (@convention(thin) (Int)->()).self) {
            action3(3)
        }
        
        if let action4 = TFYRouterManager.default.routeTo("TFYSwiftMessageRouter.LoginActionTest4(a: Swift.Int) -> Swift.Int", routerSILFunctionType: (@convention(thin) (Int)->Int).self) {
            let result = action4(4)
            print(result)
        }
        
        if let action5 = TFYRouterManager.default.routeTo("TFYSwiftMessageRouter.LoginActionTest5(a: Swift.Int, _: __C.CGRect) -> ()", routerSILFunctionType: (@convention(thin) (Int, CGRect)->()).self) {
            action5(5, CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
        }
        
        if let action6 = TFYRouterManager.default.routeTo("TFYSwiftMessageRouter.LoginActionTest6(a: Swift.Int, b: __C.CGRect) -> ()", routerSILFunctionType: (@convention(thin) (Int, CGRect)->()).self) {
            action6(6, CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
        }

        if let action7 = TFYRouterManager.default.routeTo("TFYSwiftMessageRouter.LoginActionTest7(a: Swift.Int, b: __C.UIViewController) -> ()", routerSILFunctionType: (@convention(thin) (Int, UIViewController)->()).self) {
            action7(7, self)
        }
    }
}

