
Pod::Spec.new do |spec|

  spec.name         = "TFYSwiftRouter"

  spec.version      = "2.0.0"

  spec.summary      = "汇编代码的路由跳转，支持OC 于 Swift 各个界面跳转，方法跳转 数据传输,最低支持ios 13 Swift 5 "

  spec.description  = <<-DESC
  汇编代码的路由跳转，支持OC 于 Swift 各个界面跳转，方法跳转 数据传输,最低支持ios 13 Swift 5 
                   DESC

  spec.homepage     = "https://github.com/13662049573/TFYSwiftMessageRouter"
  
  spec.license      = "MIT"
  
  spec.author       = { "田风有" => "420144542@qq.com" }


  spec.source       = { :git => "https://github.com/13662049573/TFYSwiftMessageRouter.git", :tag => spec.version }


  spec.source_files  = "TFYSwiftMessageRouter/TFYSwiftRouter/**/*.{swift}"

  spec.platform     = :ios, "13.0"

  spec.swift_version = '5.0'

  spec.pod_target_xcconfig = { 'SWIFT_VERSION' => '5.0' }

  spec.requires_arc = true

end
