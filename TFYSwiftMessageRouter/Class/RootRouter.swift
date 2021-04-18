//
//  RootRouter.swift
//  TFYSwiftMessageRouter
//
//  Created by 田风有 on 2021/4/18.
//

import UIKit

//注册需要的名称
@_silgen_name("TFYSwiftMessageRouter.root")
public func RootRouter(with params: [String: Any]) -> [String: Any]? {
    guard let navi = params["navi"] as? UINavigationController else {
       return nil
    }
    let loginController = RootViewController()
    navi.pushViewController(loginController, animated: true)
    return nil
}

@_silgen_name("TFYSwiftMessageRouter.view")
public func viewRouter(with params: [String: Any]) -> [String: Any]? {
    guard let kwindow = params["window"] as? UIWindow else {
       return nil
    }
    let loginController = ViewController()
    let navi = UINavigationController(rootViewController: loginController)
    kwindow.rootViewController = navi
    return nil
}

public func loginActionTestDefault(_ params: [String: Any]) -> [String: Any]? {
    Log("Hello, loginActionTestDefault;\(params)")
    return nil
}

@inline(never)
public func LoginActionTest1() {
    Log("Hello, LoginActionTest1;")
}

public func LoginActionTest2(_ a: Int) {
    Log("Hello, LoginActionTest2; inputValue =\(a)")
}

public func LoginActionTest3(a: Int) {
    Log("Hello, LoginActionTest3; inputValue =\(a)")
}

public func LoginActionTest4(a: Int) -> Int {
    Log("Hello, LoginActionTest4; inputValue =\(a)")
    return a + 1
}

public func LoginActionTest5(a: Int, _ b: CGRect) {
    Log("Hello, LoginActionTest5; inputValue =\(a)-----\(b)")
}

public func LoginActionTest6(a: Int, b: CGRect) {
    Log("Hello, LoginActionTest6; inputValue =\(a)-------\(b)")
}

public func LoginActionTest7(a: Int, b: UIViewController) {
    Log("Hello, LoginActionTest7; inputValue =\(a)------\(b)")
}

