//
//  TFYMacros.swift
//  TFYSwiftMessageRouter
//
//  Created by 田风有 on 2021/4/17.
//

import UIKit
import Foundation

//MARK:UI  Layout
// 屏幕宽度
let kScreenH = UIScreen.main.bounds.height

// 屏幕高度
let kScreenW = UIScreen.main.bounds.width

//计算布局属性
let FIT_WIDTH : (CGFloat)->CGFloat = { f in f/750.0*kScreenW }
let FIT_Height : (CGFloat)->CGFloat = { f in f/1334.0*kScreenH }

// MARK:- 字体方法
func FONT(_ s:CGFloat)->UIFont{
    return UIFont.systemFont(ofSize:FIT_WIDTH(s));
}

// MARK:- 粗体方法
func FONT_BOLD(_ s:CGFloat)->UIFont{
    return UIFont.boldSystemFont(ofSize:FIT_WIDTH(s))
}

// MARK:颜色方法
func RGBA(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat = 1) -> UIColor {
    if #available(iOS 10.0, *) {
        return UIColor(displayP3Red: r/255.0, green: g/255.0, blue: b/255.0, alpha:a);
    } else {
        return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    };
    
}

// MARK:- 自定义log
func Log<T>(_ message : T, fileName : String = #file, lineNum : Int = #line) {
    #if DEBUG
        // 处理fileName
        let file = (fileName as NSString).lastPathComponent
        print("\(file):[\(lineNum)] \(message)")
    #endif
}
