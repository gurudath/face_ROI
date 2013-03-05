class FaceROI::Helper
  
  def self.calculate_rect(img, padding)
    if !img.has_faces? then
      top_left_x, top_left_y, faces_width, faces_height = 0, 0, img.width, img.height
    else
      x_coords, y_coords, widths, heights = [], [], [], []

      img.faces_regions.each do |region|
        x_coords << region.top_left.x << region.bottom_right.x
        y_coords << region.top_left.y << region.bottom_right.y
        widths << region.width
        heights << region.height
      end

      top_left_x = x_coords.min
      top_left_y = y_coords.min
      bottom_right_x = x_coords.max
      bottom_right_y = y_coords.max

      # average faces areas
      average_face_width  = widths.inject(:+) / widths.size
      average_face_height = heights.inject(:+) / heights.size

      # calculating the surrounding margin of the area that covers all the found faces
      #
      
      padding_top = padding[0]
      padding_right = padding[1] || padding_top
      padding_bottom = padding[2] || padding_top
      padding_left = padding[3] || padding_right
      
      # new width
      top_left_x -= average_face_width * padding_left
      bottom_right_x += average_face_width * padding_right

      top_left_y -= average_face_height * padding_top
      bottom_right_y += average_face_height * padding_bottom

      top_left_x = 0 if top_left_x < 0      
      bottom_right_x = img.width if bottom_right_x > img.width
  
      top_left_y = 0 if top_left_y < 0
      bottom_right_y = img.height if bottom_right_y > img.height
    
      faces_width = bottom_right_x - top_left_x
      faces_height = bottom_right_y - top_left_y
    end

    return top_left_x.to_i, top_left_y.to_i, faces_width.to_i, faces_height.to_i

  end

  def self.calculate_crop_rect(target_width, target_height, img_width, img_height, roi_x, roi_y, roi_width, roi_height)
    
    width= roi_width
    height= roi_height
    target_ratio=target_width.to_f/target_height
    
    if width < target_width
      width = target_width
    end
    
    if width > img_width
      width = img_width
    end

    height = width / target_ratio
     
    if height > img_height
      height = img_height
      width = height * target_ratio
    end
    
    delta_width= width - roi_width
    delta_height= height - roi_height
    top_left_x= roi_x
    top_left_y= roi_y
    
    top_left_x -= delta_width/2
    if top_left_x < 0
      top_left_x = 0 
    end
    if top_left_x + width > img_width
      top_left_x = img_width - width
    end
    
    top_left_y -= delta_height/2
    if top_left_y < 0
      top_left_y = 0 
    end
    if top_left_y + height > img_height
      top_left_y = img_height - height
    end

    return top_left_x.to_i, top_left_y.to_i, width.to_i, height.to_i
  end

end

