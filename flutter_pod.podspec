

Pod::Spec.new do |s|
  s.name             = 'flutter_pod'
  s.version          = '0.1.0'
  s.summary          = 'flutter_pod'

  s.description      = <<-DESC
        init
                       DESC

  s.homepage         = 'https://github.com/huangjian0414/flutter_pod'

  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'huangjian0414' => 'jianhuangbest@gmail.com' }
  s.source           = { :git => 'https://github.com/huangjian0414/flutter_pod', :tag => s.version.to_s }
  

  s.ios.deployment_target = '9.0'

  
  s.static_framework = true
  p = Dir::open("ios_frameworks")
  arr = Array.new
  arr.push('ios_frameworks/*.framework')
  s.ios.vendored_frameworks = arr
end
