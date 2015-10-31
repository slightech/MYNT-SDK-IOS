Pod::Spec.new do |s|

  s.name         = "MyntCoreBluetooth"
  s.version      = "1.0.0"
  s.summary      = "Slightech's Mynt BLE SDK for iOS & OSX"
  s.homepage     = 'git remote add origin https://github.com/gejw0623/MyntCoreBluetoothSDK'
  s.author       = { 'robinge' => 'robinge@slightech.com' }

  s.ios.deployment_target = '7.0'
  s.osx.deployment_target = '10.9'
  s.source       = { :git => 'git remote add origin https://github.com/gejw0623/MyntCoreBluetoothSDK.git' }
  s.requires_arc = true

  s.source_files = '*.h'
  s.preserve_path = 'libSTMyntCoreBluetooth.a'

  
  s.vendored_libraries = 'libSTMyntCoreBluetooth.a'
  s.library = 'sqlite3'
  s.ios.frameworks = 'CoreBluetooth'
  s.osx.frameworks = 'IOBluetooth'

  s.xcconfig = { 'LIBRARY_SEARCH_PATHS' => '"$(PODS_ROOT)/MyntCoreBluetooth/**"' }

end