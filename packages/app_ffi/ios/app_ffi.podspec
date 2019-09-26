#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'app_ffi'
  s.version          = '0.0.1'
  s.summary          = 'A Flutter app ffi project'
  s.description      = <<-DESC
A Flutter app ffi project
                       DESC
  s.homepage         = 'https://github.com/xinfeng-tech/flutter_libs/tree/master/packages/app_ffi'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Meituan' => '616782041@qq.com' }
  s.source           = { :path => '.' }
  s.source_files =  ['Classes/**/*', 'cpp/**/*.{h,c,cc}']
  s.public_header_files = ['Classes/**/*.h']
  s.dependency 'Flutter'

  s.ios.deployment_target = '8.0'
end

