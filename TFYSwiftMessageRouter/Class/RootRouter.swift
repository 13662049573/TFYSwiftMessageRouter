//
//  RootRouter.swift
//  TFYSwiftMessageRouter
//
//  Created by 田风有 on 2021/4/18.
//

import UIKit

//注册需要的名称
/**
 @_silgen_name()
 自动搜索和调用C函数
 
 C函数不具备重载功能，编译后的符号是在函数名前加_
 （如test函数，编译后的符号名为_test）
 所以C函数具备全局唯一性。正是利用这一特性，@_silgen_name可自动搜索和调用c函数
 */



@_silgen_name("TFYSwiftMessageRouter.root")
public func RootRouter(with params: Any?) -> Any? {
    let loginController = RootViewController()
    let title: String = (params as! BaseModel).title
    loginController._title = title
    RouterRootbasicItools.push(loginController, animated: true)
    return nil
}

//@_silgen_name其实是 Swift 的一个隐藏符号，作用是将某个 C 语言函数直接映射为 Swift 函数,这样就不需要在桥接文件中导入C语言头文件，甚至可以直接删掉C语言头文件。
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
//@inline(__always)：如果可以的话，指示编译器始终内联方法。
@inline(never)//指示编译器永不内联方法。
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

public func LoginActionTest8(a: Int, b: String, c: BaseModel) {
    print("Hello, LoginActionTest8; inputValue =", a, b, c.name)
}

@_silgen_name("TFYSwiftMessageRouter.Test9")
public func LoginActionTest9(a: Int, b: String, _ c: BaseModel) -> BaseModel {
    print("Hello, LoginActionTest9; inputValue =", a, b, c.name)
    c.name = "这是一个返回数据 9 "
    return c
}

@_silgen_name("TFYSwiftMessageRouter.Test10")
public func LoginActionTest10(a: Int, _ b: String, _ c: BaseModel) -> (BaseModel, Double) {
    print("Hello, LoginActionTest10; inputValue =", a, b, c.name)
    c.name = "这是一个返回数据 10 "
    return (c, 10.1)
}


