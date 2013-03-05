class String
  def is_binary_data?
    ( self.count( "^ -~", "^\r\n" ).fdiv(self.size) > 0.3 || self.index( "\x00" ) ) unless empty?
  end
end

module Test
  CONFIG1= {
    :face => %w(/usr/local/share/opencv/haarcascades/haarcascade_frontalface_alt_tree.xml
    /usr/local/share/opencv/haarcascades/haarcascade_frontalface_alt.xml
    /usr/local/share/opencv/haarcascades/haarcascade_profileface.xml),

    :parts => %w(/usr/local/share/opencv/haarcascades/haarcascade_mcs_nose.xml
    /usr/local/share/opencv/haarcascades/haarcascade_mcs_lefteye.xml
    /usr/local/share/opencv/haarcascades/haarcascade_mcs_righteye.xml),

    :padding => [0.6] # top, right (=top), bottom (=top), left (=right); same as CSS
  }

  CONFIG2= {
    :face => %w(/usr/local/share/opencv/haarcascades/haarcascade_frontalface_alt_tree.xml
    /usr/local/share/opencv/haarcascades/haarcascade_frontalface_alt.xml
    /usr/local/share/opencv/haarcascades/haarcascade_profileface.xml),

    :padding => [0.8, 0.8, 0.8, 0.8]
  }

  CONFIG3= {
    :face => %w(/usr/local/share/opencv/haarcascades/haarcascade_frontalface_alt_tree.xml),

    :padding => [0.8, 0.8, 0.8, 0.8]
  }

end
