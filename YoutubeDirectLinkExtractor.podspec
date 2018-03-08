Pod::Spec.new do |s|
  s.name         = "YoutubeDirectLinkExtractor"
  s.version      = "0.1.0"
  s.summary      = "Get the direct link to a YouTube video for AVPlayer"
  s.description  = <<-DESC
    YoutubeDirectLinkExtractor allows you to obtain the direct link to a YouTube video, which you can easily use with AVPlayer.
  DESC
  s.homepage     = "https://github.com/devandsev/YoutubeDirectLinkExtractor"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Andrey Sevrikov" => "devandsev@gmail.com" }
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.source       = { :git => s.homepage + ".git", :tag => s.version.to_s }
  s.source_files  = "Sources/**/*"
  s.frameworks   = "Foundation", "AVFoundation"
end
