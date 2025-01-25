# TFYSwiftRouter

[![Platform](https://img.shields.io/badge/platform-iOS-blue.svg?style=flat)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat)](https://developer.apple.com/swift)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](http://mit-license.org)
[![CocoaPods](https://img.shields.io/cocoapods/v/TFYSwiftRouter.svg)](https://cocoapods.org/pods/TFYSwiftRouter)

TFYSwiftRouter 是一个轻量级、高性能的 iOS 路由框架，支持 Swift 和 Objective-C 混编项目。它提供了优雅的路由跳转、方法调用和数据传输解决方案。

## 特性

- [x] 支持 Swift 和 Objective-C 混编项目
- [x] 支持界面跳转路由（Push/Present）
- [x] 支持任意方法调用路由
- [x] 支持参数传递和回调
- [x] 支持模块化开发
- [x] 线程安全
- [x] 高性能符号查找
- [x] 支持 iOS 15+ 
- [x] 支持 Swift 5.0+

## 安装

### CocoaPods

```ruby
pod 'TFYSwiftRouter'
```

## 使用方法

### 1. 基础配置

```swift
import TFYSwiftRouter

// 开启日志(可选)
TFYRouterManager.openLog()
```

### 2. 路由注册

```swift
// Swift 方法路由
@_silgen_name("ModuleName.methodName")
func routerMethod(_ params: [String: Any]) -> [String: Any]? {
    // 处理逻辑
    return ["result": true]
}

// OC 方法路由
ROUTER_FUNCTION("ModuleName.methodName") {
    NSDictionary *params = (NSDictionary *)args;
    // 处理逻辑
    return @{@"result": @(YES)};
}
```

### 3. 路由调用

```swift
// Swift 调用
TFYRouterManager.default.routeTo("ModuleName.methodName")(param1: "value1", param2: "value2")

// OC 调用
[TFYRouterManager.default ocRouteTo:@"ModuleName.methodName"](@"param1": @"value1", @"param2": @"value2");

// 视图控制器跳转
let vc = TFYRouterManager.default.routeToVC("ModuleName.ViewControllerName", parame: ["key": "value"])
```

### 4. 错误处理

```swift
// 注册默认的未找到处理
TFYRouterManager.default.registeredDefultNotFoundHandler { router in
    print("路由未找到: \(router)")
}

// 单次调用的错误处理
TFYRouterManager.default.routeAndHandleNotFound("ModuleName.methodName") {
    print("该路由未找到")
}
```

## 示例项目

查看并运行 `/Example` 文件夹中的示例项目，了解更多使用细节。

## 系统要求

- iOS 15.0+
- Swift 5.0+
- Xcode 14.0+

## 作者

田风有

## 许可证

TFYSwiftRouter 基于 MIT 许可证开源。详细内容请查看 LICENSE 文件。

## 更新日志

### 2.1.8
- 初始版本发布
- 支持 Swift 和 OC 混编项目的路由功能
- 支持界面跳转和方法调用