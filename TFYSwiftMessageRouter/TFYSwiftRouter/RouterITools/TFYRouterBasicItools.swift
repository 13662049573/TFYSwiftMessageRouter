//
//  TFYRouterBasicItools.swift
//  TFYSwiftMessageRouter
//
//  Created by 田风有 on 2021/4/20.
//

import Foundation
import UIKit

public func KeyWindows() -> UIWindow? {
    var keyWindow:UIWindow?
    if #available(iOS 13.0, *) {
        keyWindow = UIApplication.shared.connectedScenes
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows.first
    } else {
        if let window = UIApplication.shared.delegate?.window as? UIWindow {
            keyWindow = window
        } else {
            for window in UIApplication.shared.windows where window.windowLevel == .normal && !window.isHidden {
                keyWindow = window
            }
            keyWindow = UIApplication.shared.windows.first
        }
    }
    return keyWindow
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

public protocol TFYRouterBasicItools {
    static var TFYRouterBasicItools:UIViewController?{get}
    static func push(_ viewController:UIViewController,animated:Bool)
    static func present(_ viewController:UIViewController,animated:Bool,completion:(()->Void)?)
}

extension TFYRouterBasicItools {
    public static func push(_ viewController:UIViewController,animated:Bool) {
        TFYRouterBasicItools?.currentNavigationController?.pushViewController(viewController, animated: animated)
    }
    
    public static func present(_ viewController:UIViewController,animated:Bool,completion:(()->Void)?) {
        var presenter = TFYRouterBasicItools
        while let presented = presenter?.presentedViewController {
            presenter = presented
        }
        presenter?.present(viewController, animated: animated, completion: completion)
    }
}

public struct RouterTopbasicItools:TFYRouterBasicItools {
    public static var TFYRouterBasicItools:UIViewController?{UIViewController.topViewController}
}

public struct RouterRootbasicItools:TFYRouterBasicItools {
    public static var TFYRouterBasicItools:UIViewController?{UIViewController.rootViewController}
}
