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
  s.source_files =  ['Classes/**/*', 'cpp/**/*.{h,c,cc}']
  s.public_header_files = ['Classes/**/*.h']
  s.dependency 'Flutter'

  s.ios.deployment_target = '8.0'
end

