# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'face_ROI/version'

Gem::Specification.new do |spec|
  spec.name          = "face_ROI"
  spec.version       = FaceROI::VERSION
  spec.authors       = ["Deepak Kumar"]
  spec.email         = ["deepak@kreatio.com"]
  spec.description   = %q{Find ROI in an image using face detection}
  spec.summary       = %q{Using OpenCV detect faces ina an image and calculate a rectangle that includes all detected faces}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency("ruby-opencv", ">=0.0.8")

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
