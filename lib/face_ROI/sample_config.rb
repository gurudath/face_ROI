module FaceROI
  class SampleConfig
    def self.haarcascades_base
      File.expand_path('share/opencv/haarcascades/', FaceROI::OPENCV_BASE)
    end

    # Most optimal configuration, computation intensive, low chances of false positive
    def self.config1
      {
        :face => %w(haarcascade_frontalface_alt_tree.xml haarcascade_frontalface_alt.xml
        haarcascade_profileface.xml).map{|p| File.expand_path(p, haarcascades_base)},

        :parts => %w(haarcascade_mcs_nose.xml haarcascade_mcs_lefteye.xml
        haarcascade_mcs_righteye.xml).map{|p| File.expand_path(p, haarcascades_base)},

        :padding => [0.6] # top, right (=top), bottom (=top), left (=right); same as CSS
      }
    end

    # High chances of false positive
    def self.config2
      {
        :face => %w(haarcascade_frontalface_alt_tree.xml haarcascade_frontalface_alt.xml
        haarcascade_profileface.xml).map{|p| File.expand_path(p, haarcascades_base)},

        :padding => [0.8, 0.8, 0.8, 0.8]
      }
    end

    # Simple, high chances of false positive
    def self.config3
      {
        :face => %w(haarcascade_frontalface_alt_tree.xml).map{|p| File.expand_path(p, haarcascades_base)},

        :padding => [0.8, 0.8, 0.8, 0.8]
      }
    end

  end
end
