Pod::Spec.new do |s|
s.platform = :ios
s.ios.deployment_target = '15.0'
s.name = "Core"
s.summary = "Dicoding Core.framework for modularization chapter"
s.requires_arc = true
s.version = "1.0.3"
s.license = { :type => "MIT", :file => "LICENSE" }
s.author = { "Dimas Panuji Wicaksono" => "myzrael005@gmail.com" }
s.homepage = "https://github.com/dimspawn/The-Movie-Time-Core"
s.source = { :git => "https://github.com/dimspawn/The-Movie-Time-Core.git", :tag => "#{s.version}" }
s.framework = "UIKit"
s.source_files = "Core/**/*.{swift}"
s.swift_version = "5.5.2"

end