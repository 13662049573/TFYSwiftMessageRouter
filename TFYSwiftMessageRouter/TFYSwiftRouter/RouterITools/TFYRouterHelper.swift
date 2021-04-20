//
//  TFYRouterHelper.swift
//  TFYSwiftMessageRouter
//
//  Created by 田风有 on 2021/4/18.
//

import Foundation

func isFunction(_ type: Any.Type) -> Bool {
    assert(MemoryLayout.size(ofValue: type) == MemoryLayout<UnsafeMutablePointer<Int>>.size)
    
    let typePointer = unsafeBitCast(type, to: UnsafeMutablePointer<Int>.self)
    return typePointer.pointee == (2 | 0x100 | 0x200)
}

func swift_demangle(_ mangledName: String) -> String? {
    let cname = mangledName.withCString({ $0 })
    if let demangledName = get_swift_demangle(mangledName: cname, mangledNameLength: UInt(mangledName.utf8.count), outputBuffer: nil, outputBufferSize: nil, flags: 0) {
        return String(cString: demangledName)
    }
    return nil
}

// swift_demangle: Swift/Swift libraries/SwiftDemangling/Header Files/Demangle.h
/**
 @_silgen_name()
 自动搜索和调用C函数
 
 C函数不具备重载功能，编译后的符号是在函数名前加_
 （如test函数，编译后的符号名为_test）
 所以C函数具备全局唯一性。正是利用这一特性，@_silgen_name可自动搜索和调用c函数
 */
@_silgen_name("swift_demangle")
private func get_swift_demangle(mangledName: UnsafePointer<CChar>?,
                                mangledNameLength: UInt,
                                outputBuffer: UnsafeMutablePointer<UInt8>?,
                                outputBufferSize: UnsafeMutablePointer<Int>?,
                                flags: UInt32
                                ) -> UnsafeMutablePointer<CChar>?
