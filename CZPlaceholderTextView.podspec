Pod::Spec.new do |s|
  s.name             = "CZPlaceholderTextView"
  s.version          = "0.1.0"
  s.summary          = "UITextView subclass with multiline placeholder support."
  s.description      = <<-DESC
                       `UITextView` subclass with multiline placeholder support.
                       DESC
  s.homepage         = "https://github.com/carezone/CZPlaceholderTextView"
  s.license          = 'MIT'
  s.author           = { "Victor Ilyukevich" => "ilyukevich.victor@gmail.com" }
  s.source           = { :git => "https://github.com/carezone/CZPlaceholderTextView.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/carezone'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
end
