module FaceROI
  class Finder
    attr_accessor :faces_regions
    
    @@defaults = FaceROI::CONFIG1
    
    def has_faces?
      @faces_regions.size > 0
    end

    def initialize(file, options)
      options = @@defaults.merge(options)
      
      @image = OpenCV::IplImage.load(file, 1)

      @faces_regions = detect_regions(options[:face])

      unless options[:parts].nil?
        faces_parts_regions = detect_regions(options[:parts])

        @faces_regions.reject! do |face_region|
          region = faces_parts_regions.detect do |part_region|
          # part of a face can't be bigger than the face itself
            face_region.collide?(part_region) && face_region > part_region
          end
          
          region.nil?
        end
      end
      @faces_rect= FaceROI::Helper.calculate_rect(self, options[:padding])
    end

    def roi
      @faces_rect
    end
    
    def calculate_crop_rect(target_width, target_height)
      x,y,w,h= @faces_rect
      @crop_rect= FaceROI::Helper.calculate_crop_rect(target_width, target_height, width(), height(), x,y,w,h)
    end
    
    #  private
    def detect_regions(classifiers, color = OpenCV::CvColor::Blue)
      regions = []

      classifiers.each do |classifier|
        detector = OpenCV::CvHaarClassifierCascade::load(classifier)
        detector.detect_objects(@image) do |region|
          region.color = color
          regions << region
        end
      end

      regions
    end
    
    def image_with_faces
      image= @image.copy
      
      @faces_regions.each do |region|
        image.rectangle! region.top_left, region.bottom_right, :color => region.color
      end
      
      if @faces_rect
        x,y,w,h= @faces_rect
        image.rectangle! OpenCV::CvPoint.new(x, y), OpenCV::CvPoint.new(x+w, y+h), :color => OpenCV::CvColor::Red
      end

      image
    end
    
    def width
      @image.width
    end
    
    def height
      @image.height
    end
  end
end
