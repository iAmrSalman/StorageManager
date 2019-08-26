Pod::Spec.new do |s|
  s.name         = 'StorageManager'
  s.version      = '0.1.7'
	s.swift_versions = '5.0'
  s.summary      = 'Safe and easy way to use FileManager.'
  s.description  = <<-DESC
    FileManager framework that handels Store, fetch, delete and update files in local storage.
  DESC
  s.homepage     = 'https://github.com/iAmrSalman/StorageManager'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { 'Amr Salman' => 'iamrsalman@gmail.com' }
  s.social_media_url   = 'https://twitter.com/@iAmrSalman'
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target = '9.0'
  s.source       = { :git => 'https://github.com/iAmrSalman/StorageManager.git', :tag => s.version.to_s }
  s.source_files  = 'Sources/**/*'
  s.frameworks  = 'Foundation'
end
