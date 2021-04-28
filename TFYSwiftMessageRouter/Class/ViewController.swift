//
//  ViewController.swift
//  TFYSwiftMessageRouter
//
//  Created by 田风有 on 2021/4/17.
//

import UIKit

///被final修饰的方法、下标、属性，禁止被重写 被final修饰的类，禁止被继承
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
        TFYRouterManager.default.routeTo("TFYSwiftMessageRouter.root")?(title:"测试数据")
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
            Log(result)
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
        
        if let action8 = TFYRouterManager.default.routeTo("TFYSwiftMessageRouter.LoginActionTest8(a: Swift.Int, b: Swift.String, c: TFYSwiftMessageRouter.BaseModel) -> ()", routerSILFunctionType: (@convention(thin) (Int, String, BaseModel)->()).self) {
            action8(8, "Action8", BaseModel(_name: "Tanner.Jin"))
        }
        
        if let action9 = TFYRouterManager.default.routeTo("TFYSwiftMessageRouter.Test9", routerSILFunctionType: (@convention(thin) (Int, String, BaseModel)->BaseModel).self) {
            let newModel = action9(9, "Action9", BaseModel(_name: "Tanner.Jin"))
            print(newModel.name, "\n")
        }
        
        if let action10 = TFYRouterManager.default.routeTo("TFYSwiftMessageRouter.Test10", routerSILFunctionType: (@convention(thin) (Int, String, BaseModel) -> (BaseModel, Double)).self) {
            let result = action10(10, "Action10", BaseModel(_name: "Tanner.Jin"))
            let alert = UIAlertController(title: "结果", message: result.0.name, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            UIViewController.topViewController?.present(alert, animated: true) {
                print(result.0.name, result.1)
            }
        }
    }
}

