Pod::Spec.new do |s|
  s.name         = "ConfiguRateSDK"
  s.version      = "1.0.2"
  s.summary      = "Integrate a button to show ConfiguRate survey"
  s.homepage     = "http://goappable.com/"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Nguyen Anh Viet" => "naviet2308@gmail.com" }
  s.platform     = :ios, '9.0'
  s.source       = { :git => "https://github.com/naviet2308/ConfiguRateSDK.git", :tag => s.version }
  s.source_files = 'ConfiguRateSDK.framework/Headers/*.{h}'
  s.preserve_paths =  'ConfiguRateSDK.framework/*'
  s.vendored_frameworks = 'ConfiguRateSDK.framework'
  s.resource            = 'ConfiguRateSDK.framework/*.png'
  s.requires_arc = true
end
