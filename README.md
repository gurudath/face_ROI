# FaceROI

A simple Ruby Gem to calculate an ROI in an image by indetifying faces using [OpenCV] (http://opencv.org/). This
 can be used to create optimal crops of images.

Adapted from and inspired by [paperclip-facecrop] (https://github.com/dagi3d/paperclip-facecrop).

## Installation

Install OpenCV (Mac OSX)

````
$ sudo port install cmake # in case cmake has not already been installed

$ tar xvzf OpenCV-2.4.0.tar.bz2
$ cd OpenCV-2.4.0
$ mkdir build
$ cd build
$ cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local ..
$ make
$ sudo make install
````

For other platforms: [Install Guide] (http://docs.opencv.org/doc/tutorials/introduction/table_of_content_introduction/table_of_content_introduction.html)

Install [Ruby OpenCV] (https://github.com/ruby-opencv/ruby-opencv/)

````
$ gem install ruby-opencv -- --with-opencv-dir=/usr/local
````

Install face_ROI

Add this line to your application's Gemfile:

    gem 'face_ROI'

And then execute:

````
$ bundle
````

Or install it yourself as:

````
$ gem install face_ROI
````

## Usage

### Set path of OpenCV base directory
```ruby
module FaceROI
  OPENCV_BASE= '/usr/local'
end
````

### Sample usage
```ruby
require 'face_ROI'

path='test/IMG_0465.jpg'
f=FaceROI::Finder.new(path, FaceROI::CONFIG1)

# In case there were no faces detected it will return the full image
roi_x, roi_y, roi_width, roi_height= f.roi
puts "(#{path}) has ROI?: #{f.has_roi?}"
puts "ROI Offset (#{roi_x}, #{roi_y}), width: #{roi_width}, height #{roi_height}"

# Save image for debugging purposes
image=f.image_with_faces
image.save('test/IMG_0465-with-faces.jpg')
````

### Config help
From face_ROI/sample_config

````ruby
  # Most optimal configuration, computation intensive, low chances of false positive
  CONFIG1= {
    :face => %w(haarcascade_frontalface_alt_tree.xml haarcascade_frontalface_alt.xml
    haarcascade_profileface.xml).map{|p| File.expand_path(p, HAARCASCADES_BASE)},

    :parts => %w(haarcascade_mcs_nose.xml haarcascade_mcs_lefteye.xml
    haarcascade_mcs_righteye.xml).map{|p| File.expand_path(p, HAARCASCADES_BASE)},

    :padding => [0.6] # top, right (=top), bottom (=top), left (=right); same as CSS
  }

  # High chances of false positive
  CONFIG2= {
    :face => %w(haarcascade_frontalface_alt_tree.xml haarcascade_frontalface_alt.xml
    haarcascade_profileface.xml).map{|p| File.expand_path(p, HAARCASCADES_BASE)},

    :padding => [0.8, 0.8, 0.8, 0.8] # top, right (=top), bottom (=top), left (=right); same as CSS
  }

  # Simple, high chances of false positive
  CONFIG3= {
    :face => %w(haarcascade_frontalface_alt_tree.xml).map{|p| File.expand_path(p, HAARCASCADES_BASE)},

    :padding => [0.8, 0.8, 0.8, 0.8] # top, right (=top), bottom (=top), left (=right); same as CSS
  }
````

Use any of the above, adapt, or create your own configuration.

For padding - just like CSS - 1, 2, 3, or 4 values can be provided.

Also see [paperclip-facecrop] (https://github.com/dagi3d/paperclip-facecrop) for few more details.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
