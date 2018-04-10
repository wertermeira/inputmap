require "inputmap/version"
require "active_support"

module Inputmap
  class Client

    def initialize(config = {})
      @key = config[:key] || 'AIzaSyB70Hu6l9Ekf1hnbPKJy2sCgsxrYFfTTO4'
      @coordinates = config[:coordinates].gsub(/[()]/,'') || '-23.583233, -46.634771'
      @input_id = config[:input_id] || 'input_id'
      @element_id = config[:element_id] = 'map'
      @zoom = config[:zoom] || 15
    end

    def render
      "<script src='https://maps.googleapis.com/maps/api/js?key=#{@key}'></script>
       <script type='text/javascript'>
            var map;
        var marker;

        function initialize() {
          var my_position = new google.maps.LatLng(#{@coordinates});
            var map = new google.maps.Map(document.getElementById('#{@element_id}'), {
              center: my_position,
              zoom: #{@zoom}
          });
          var marker = new google.maps.Marker({
              position: my_position,
              map: map
          });
          // double click event
          google.maps.event.addListener(map, 'click', function(e) {
            var positionDoubleclick = e.latLng;
            marker.setPosition(positionDoubleclick);
            var input = document.getElementById('#{@input_id}');
            input.value = positionDoubleclick;
          });
        }
        google.maps.event.addDomListener(window, 'load', initialize);

       </script>".html_safe
    end
  end
end
