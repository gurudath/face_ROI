$: << 'lib'

require 'face_ROI'
require './test/setup.rb'
require 'rmagick'
  
# Test::CONFIG1
  
def display(image)
  window = OpenCV::GUI::Window.new('Face detection')
  window.show(image)
  OpenCV::GUI::wait_key
  window.destroy  
end

def test_me(path, show_it=false)
  dimensions = [[50,50],[150,100],[200,300],[400,250],[3000,1000]]
  
  f=FaceROI::Finder.new(path, Test::CONFIG1)

  image=f.image_with_faces
  face_path = path.sub(/\./, "-faces.")
  face_path = "out/#{face_path}"
  image.save(face_path)
  
  rm_img=Magick::Image.read(path)[0]
  img_width=rm_img.columns
  img_height=rm_img.rows
  
  roi_x, roi_y, roi_width, roi_height= f.roi

  dimensions.each do |dimension|
    target_width, target_height = dimension
    offset_x, offset_y, crop_width, crop_height = 
      FaceROI::Helper.calculate_crop_rect(target_width, target_height, img_width, img_height, roi_x, roi_y, roi_width, roi_height)

    out_path = path.sub(/\./, "-#{target_width}x#{target_height}.")
    out_path = "out/#{out_path}"
    
    rm_img.excerpt(offset_x, offset_y, crop_width, crop_height).resize(target_width, target_height).write(out_path)
    
    if show_it then
      img= image.copy
      x,y,w,h= offset_x, offset_y, crop_width, crop_height
      img.rectangle! OpenCV::CvPoint.new(x, y), OpenCV::CvPoint.new(x+w, y+h), :color => OpenCV::CvColor::Green

      display img
    end
  end
end

#test_me 'test/IMG_2856.jpg'
test_me 'test/IMG_0465.jpg', true
#test_me 'test/IMG_0341.jpg'
exit 0

Dir.glob('test/*.jpg').each do |p|
  test_me p, true
end


