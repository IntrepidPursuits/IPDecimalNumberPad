Pod::Spec.new do |s|
  s.name             = "IPDecimalNumberPad"
  s.version          = "0.1.0"
  s.summary          = "A number pad control consisting of digits 0-9, a decimal point and a delete button."
  s.description      = <<-DESC
Sometimes a design requires a number pad that is not contained in a keyboard. This UIControl subclass provides a customizeable and resizeable number pad. 
                       DESC
  s.homepage         = "https://github.com/IntrepidPursuits/IPDecimalNumberPad"
  s.license          = 'MIT'
  s.author           = { "Nick Servidio" => "servidionicholas@gmail.com" }
  s.source           = { :git => "https://github.com/IntrepidPursuits/IPDecimalNumberPad.git", :tag => "0.1.0" }
  s.platform         = :ios, '8.0'
  s.requires_arc     = true
  s.source_files     = 'Pod/Classes/**/*'
  s.resource_bundle  = {'IPDecimalNumberPad' => 'Pod/Assets/*.png'}
  s.frameworks       = 'UIKit'
  s.dependency 'IP-UIKit-Wisdom', '0.0.7'
end
