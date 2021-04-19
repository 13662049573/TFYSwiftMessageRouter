//
//  TFYbasicItools.swift
//  TFYSwiftMessageRouter
//
//  Created by 田风有 on 2021/4/17.
//

import Foundation
import UIKit

public func KeyWindows() -> UIWindow? {
    var window:UIWindow? = nil
    if #available(iOS 13.0, *) {
        for windowScene:UIWindowScene in ((UIApplication.shared.connectedScenes as? Set<UIWindowScene>)!) {
            if windowScene.activationState == .foregroundActive {
                window = windowScene.windows.first
                break
            }
        }
        return window
    } else {
        return UIApplication.shared.keyWindow
    }
}

extension UIViewController {
    public static var topViewController:UIViewController? {
        var topController = KeyWindows()?.rootViewController
        while let presonted = topController?.presentedViewController {
            topController = presonted
        }
        return topController
    }
    
    public static var rootViewController:UIViewController? {
        KeyWindows()?.rootViewController
    }
    
    public var currentNavigationController:UINavigationController? {
        if let navi = self as? UINavigationController {
            return navi
        } else if let tabbar = self as? UITabBarController {
            let selectedController = tabbar.selectedViewController
            if let navi = selectedController as? UINavigationController {
                return navi
            } else {
                return selectedController?.navigationController
            }
        } else {
            return navigationController
        }
    }
    
    public func dismissToRoot(animated flag:Bool,completion:(()-> Void)? = nil) {
        Self.rootViewController?.dismiss(animated: flag, completion: completion)
    }
}

public protocol TFYbasicItools {
    static var TFYbasicItools:UIViewController?{get}
    static func push(_ viewController:UIViewController,animated:Bool)
    static func present(_ viewController:UIViewController,animated:Bool,completion:(()->Void)?)
}

extension TFYbasicItools {
    public static func push(_ viewController:UIViewController,animated:Bool) {
        TFYbasicItools?.currentNavigationController?.pushViewController(viewController, animated: animated)
    }
    
    public static func present(_ viewController:UIViewController,animated:Bool,completion:(()->Void)?) {
        var presenter = TFYbasicItools
        while let presented = presenter?.presentedViewController {
            presenter = presented
        }
        presenter?.present(viewController, animated: animated, completion: completion)
    }
}

public struct TopbasicItools:TFYbasicItools {
    public static var TFYbasicItools:UIViewController?{UIViewController.topViewController}
}

public struct RootbasicItools:TFYbasicItools {
    public static var TFYbasicItools:UIViewController?{UIViewController.rootViewController}
}

///多线程开发 – 异步
public typealias Block = () -> Void

public func async(_ task: @escaping Block) {
    _async(task)
}

public func async(_ task: @escaping Block, _ mainTask: @escaping Block) {
    _async(task, mainTask)
}

private func _async(_ task: @escaping Block,_ mainTask: Block? = nil) {
    let item = DispatchWorkItem(block: task)
    DispatchQueue.global().async(execute: item)
    if let main = mainTask {
        item.notify(queue: DispatchQueue.main, execute: main)
    }
}

///多线程开发 – 延迟
@discardableResult public func delay(_ seconds: Double,_ block: @escaping Block) -> DispatchWorkItem {
    let item = DispatchWorkItem(block: block)
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds, execute: item)
    return item
}

///多线程开发 – 异步延迟
@discardableResult public func asyncDelay(_ seconds: Double, _ task: @escaping Block) -> DispatchWorkItem {
    return _asyncDelay(seconds, task)
}

@discardableResult public func asyncDelay(_ seconds: Double, _ task: @escaping Block, _ mainTask: @escaping Block) -> DispatchWorkItem {
    return _asyncDelay(seconds, task, mainTask)
}

private  func _asyncDelay(_ seconds: Double,_ task: @escaping Block, _ mainTask: Block? = nil) -> DispatchWorkItem {
    let item = DispatchWorkItem(block: task)
    DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + seconds, execute: item)
    if let main = mainTask {
        item.notify(queue: DispatchQueue.main, execute: main)
    }
    return item

}
