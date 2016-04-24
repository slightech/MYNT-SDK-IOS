Pod::Spec.new do |s|

  s.name         = "MYNT-SDK-IOS"
  s.version      = "1.0.0"
  s.summary      = "Slightech's Mynt BLE SDK for iOS & OSX"
  s.homepage     = 'https://github.com/slightech/MYNT-SDK-IOS'
  s.author       = { 'slightech' => 'robinge@slightech.com' }
  s.license      = { :type => 'Copyright', :text => 'LICENSE Copyright 2014 - 2016 Slightech.com, Inc. All rights reserved.' }

  s.platform = :ios
  s.platform = :osx
  s.ios.deployment_target = '7.0'
  s.osx.deployment_target = '10.9'
  s.source       = { :git => 'https://github.com/slightech/MYNT-SDK-IOS.git', :tag => "1.0.0"}
  s.requires_arc = true

  s.source_files = 'MYNT-SDK-IOS/*.h'
  s.ios.preserve_path = 'MYNT-SDK-IOS/ios/libSTMyntBluetooth.a'
  s.osx.preserve_path = 'MYNT-SDK-IOS/osx/libSTMyntBluetooth.a'

  
  s.ios.vendored_libraries = 'MYNT-SDK-IOS/ios/libSTMyntBluetooth.a'
  s.osx.vendored_libraries = 'MYNT-SDK-IOS/osx/libSTMyntBluetooth.a'
  s.library = 'sqlite3'
  s.ios.frameworks = 'CoreBluetooth'
  s.osx.frameworks = 'IOBluetooth'

  s.xcconfig = { 'LIBRARY_SEARCH_PATHS' => '"$(PODS_ROOT)/MYNT-SDK-IOS/MYNT-SDK-IOS/**"' }

end
