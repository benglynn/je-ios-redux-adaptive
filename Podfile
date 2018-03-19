use_frameworks!

target 'ios' do
  pod 'RxSwift', '4.0.0'
  pod 'RxCocoa', '4.0.0'
  pod 'RxDataSources', '~> 3.0'
end
  

post_install do |installer|
  installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
          config.build_settings['SWIFT_VERSION'] = '4.0'
      end
  end
end
