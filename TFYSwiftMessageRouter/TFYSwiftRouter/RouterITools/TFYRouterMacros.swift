//
//  TFYRouterMacros.swift
//  TFYSwiftMessageRouter
//
//  Created by 田风有 on 2021/4/20.
//

import UIKit
import Foundation

//MARK:UI  Layout

/// 屏幕宽度
public let kScreenH = UIScreen.main.bounds.height

/// 屏幕高度
public let kScreenW = UIScreen.main.bounds.width

/// 计算布局属性
public let FIT_WIDTH: (CGFloat)->CGFloat = { f in f/750.0*kScreenW }
public let FIT_Height: (CGFloat)->CGFloat = { f in f/1334.0*kScreenH }

/// - 字体方法
public func FONT(_ s: CGFloat)->UIFont{
    return UIFont.systemFont(ofSize:FIT_WIDTH(s));
}

/// - 粗体方法
public func FONT_BOLD(_ s: CGFloat)->UIFont{
    return UIFont.boldSystemFont(ofSize:FIT_WIDTH(s))
}

/// 颜色方法
public func RGBA(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) -> UIColor {
    if #available(iOS 10.0, *) {
        return UIColor(displayP3Red: r/255.0, green: g/255.0, blue: b/255.0, alpha:a);
    } else {
        return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    };
}

/// - 自定义打印
public func Log<T>(_ message: T, fileName: String = #file, lineNum: Int = #line) {
    #if DEBUG
        // 处理fileName
        let file = (fileName as NSString).lastPathComponent
        print("\(file):[\(lineNum)] \(message)")
    #endif
}

/// 判断是否是IphoneX
public var isPhoneX: Bool {
    get {
        if #available(iOS 11.0, *) {
            if UIApplication.shared.windows.first!.safeAreaInsets.bottom > 0 {
                return true
            }
        }
        return false
    }
}
