#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'app_ffi'
  s.version          = '1.0.0'
  s.summary          = 'A flutter-ffi template'
  s.description      = <<-DESC
Provide flutter-ffi template code in Flutter (c/c++ build and dart wrapper)
                       DESC
  s.homepage         = 'https://github.com/xinfeng-tech/flutter_libs/tree/master/packages/app_ffi'
  s.license          = { :type => "MIT", :file => '../../../LICENSE' }
  s.author           = { 'Meituan' => '616782041@qq.com' }
  s.source           = { :git => 'https://github.com/xinfeng-tech/flutter_libs.git',:tag => "v#{s.version}"  }
  s.source_files =  ['Classes/**/*', 'cpp/src/**/*.{h,c,cc}','cpp/include/*.h']
  s.public_header_files = ['Classes/**/*.h','cpp/include/*.h']
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
end

