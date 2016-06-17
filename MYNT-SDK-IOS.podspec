Pod::Spec.new do |s|

  s.name         = "MYNT-SDK-IOS"
  s.version      = "1.1.3"
  s.summary      = "Slightech's Mynt BLE SDK for iOS & OSX"
  s.homepage     = 'https://github.com/slightech/MYNT-SDK-IOS'
  s.author       = { 'robinge' => 'robinge@slightech.com' }
  s.license      = { :type => 'Copyright', :text => 'LICENSE Copyright 2014 - 2016 Slightech.com, Inc. All rights reserved.' }
  s.source       = { :git => 'https://github.com/slightech/MYNT-SDK-IOS.git', :tag => "#{s.version}"}

  s.ios.deployment_target = '7.0'
  s.ios.preserve_path = 'MYNT-SDK-IOS/ios/libSTMyntBluetooth.a'
  s.ios.vendored_libraries = 'MYNT-SDK-IOS/ios/libSTMyntBluetooth.a'
  s.ios.frameworks = 'CoreBluetooth'

  s.osx.deployment_target = '10.9'
  s.osx.preserve_path = 'MYNT-SDK-IOS/osx/libSTMyntBluetooth.a'
  s.osx.vendored_libraries = 'MYNT-SDK-IOS/osx/libSTMyntBluetooth.a'
  s.osx.frameworks = 'IOBluetooth'

  s.source_files = 'MYNT-SDK-IOS/*.h'

  s.requires_arc = true
  s.library = 'sqlite3'
  s.xcconfig = { 'LIBRARY_SEARCH_PATHS' => '"$(PODS_ROOT)/MYNT-SDK-IOS/MYNT-SDK-IOS/**"' }

end
