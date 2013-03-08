module FaceROI

  HAARCASCADES_BASE= File.expand_path('share/opencv/haarcascades/', FaceROI::OPENCV_BASE)

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

    :padding => [0.8, 0.8, 0.8, 0.8]
  }

  # Simple, high chances of false positive
  CONFIG3= {
    :face => %w(haarcascade_frontalface_alt_tree.xml).map{|p| File.expand_path(p, HAARCASCADES_BASE)},

    :padding => [0.8, 0.8, 0.8, 0.8]
  }

end
