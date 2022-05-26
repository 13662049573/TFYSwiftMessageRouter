
Pod::Spec.new do |spec|

  spec.name         = "TFYSwiftRouter"

  spec.version      = "2.1.6"

  spec.summary      = "汇编代码的路由跳转，支持OC 于 Swift 各个界面跳转，方法跳转 数据传输,最低支持ios 12 Swift 5 "

  spec.description  = <<-DESC
  汇编代码的路由跳转，支持OC 于 Swift 各个界面跳转，方法跳转 数据传输,最低支持ios 12 Swift 5 
                   DESC

  spec.homepage     = "https://github.com/13662049573/TFYSwiftMessageRouter"
  
  spec.license      = "MIT"
  
  spec.author       = { "田风有" => "420144542@qq.com" }


  spec.source       = { :git => "https://github.com/13662049573/TFYSwiftMessageRouter.git", :tag => spec.version }


  spec.subspec 'RouterITools' do |ss|
    ss.source_files  = "TFYSwiftMessageRouter/TFYSwiftRouter/RouterITools/*.{swift}"
  end

  spec.subspec 'RouterLock' do |ss|
    ss.source_files  = "TFYSwiftMessageRouter/TFYSwiftRouter/RouterLock/*.{swift}"
  end

  spec.subspec 'RouterOC' do |ss|
    ss.source_files  = "TFYSwiftMessageRouter/TFYSwiftRouter/RouterOC/*.{swift}"
    ss.dependency "TFYSwiftRouter/RouterLock"
    ss.dependency "TFYSwiftRouter/RouterSwift"
  end

  spec.subspec 'RouterSwift' do |ss|
    ss.source_files  = "TFYSwiftMessageRouter/TFYSwiftRouter/RouterSwift/*.{swift}"
    ss.dependency "TFYSwiftRouter/RouterLock"
  end

  spec.platform     = :ios, "12.0"

  spec.swift_version = '5.0'

  spec.pod_target_xcconfig = { 'SWIFT_VERSION' => '5.0' }

  spec.requires_arc = true

end
