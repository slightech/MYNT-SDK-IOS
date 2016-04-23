Pod::Spec.new do |s|

  s.name         = "MYNT-SDK-IOS"
  s.version      = "1.0.0"
  s.summary      = "Slightech's Mynt BLE SDK for iOS & OSX"
  s.homepage     = 'https://github.com/slightech/MYNT-SDK-IOS'
  s.author       = { 'robinge' => 'robinge@slightech.com' }

  s.ios.deployment_target = '7.0'
  s.osx.deployment_target = '10.9'
  s.source       = { :git => 'https://github.com/slightech/MYNT-SDK-IOS.git' }
  s.requires_arc = true

  s.source_files = 'MYNT-SDK-IOS/*.h'
  s.preserve_path = 'MYNT-SDK-IOS/libSTMyntBluetooth.a'

  
  s.vendored_libraries = 'libSTMyntBluetooth.a'
  s.library = 'sqlite3'
  s.ios.frameworks = 'CoreBluetooth'
  s.osx.frameworks = 'IOBluetooth'

  s.xcconfig = { 'LIBRARY_SEARCH_PATHS' => '"$(PODS_ROOT)/MYNT-SDK-IOS/**"' }

end