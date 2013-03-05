$: << 'lib'

require 'face_ROI'
require './test/setup.rb'
  
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

  dimensions.each do |dimension|
    w, h = dimension
    top_left_x, top_left_y, faces_width, faces_height = f.calculate_crop_rect(w,h)
    out_path = path.sub(/\./, "-#{w}x#{h}.")
    out_path = "out/#{out_path}"
    system("convert", "-crop", "#{faces_width}x#{faces_height}+#{top_left_x}+#{top_left_y}", "-scale", "#{w}x#{h}", path, out_path)
    if show_it then
      image= f.image_with_faces
      display image
    end
  end
end

#test_me 'test/IMG_2856.jpg'
test_me 'test/IMG_0465.jpg', true
#test_me 'test/IMG_0341.jpg'

Dir.glob('test/*.jpg').each do |p|
  test_me p
end


