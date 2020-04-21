Pod::Spec.new do |s|
  s.name             = 'SafeURLChecker'
  s.version          = '0.0.2'
  s.summary          = 'A tool to enforce URL safety while using SafeURL.'
  s.homepage         = 'https://github.com/baguio/SwiftSafeURLChecker'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jhonatan A.' => '' }
  s.preserve_paths = '*'
  s.swift_version = '5.0'
  s.ios.deployment_target = '8.0'
  s.source       = {
    :http => "#{s.homepage}/releases/download/#{s.version}/SafeURLChecker.zip"
  }
end
