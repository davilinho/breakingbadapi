platform :ios, '13.0'

target 'breakingbadapi' do
  use_frameworks!

  pod 'Alamofire', '5.4.0'
  pod 'Firebase/Analytics'
  pod 'Firebase/Crashlytics'
  pod 'Firebase/Performance'
  pod "PromiseKit", "6.12.0"

  target 'breakingbadapiTests' do
    inherit! :search_paths

    pod 'Nimble', '9.0.0'
    pod 'SnapshotTesting', '~> 1.8.1'
  end

  target 'breakingbadapiUITests' do
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '5.0'
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      config.build_settings['CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER'] = 'NO'
    end
  end
end
