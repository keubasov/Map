class MapsController<ApplicationController

  def city

  end

  def dtr(degree)
    degree * Math::PI/180
  end

  def get_buildings
    lat1 = params[:coords][0].to_f
    long1 = params[:coords][1].to_f
    @coords = []
    our_coords = Coord.all.to_a
    our_coords.each do |coord|
      lat2, long2 = coord.latitude, coord.longitude
      distance = 6371*Math.acos(Math.sin(dtr lat1)*Math.sin(dtr lat2) + Math.cos(dtr lat1)*Math.cos(dtr lat2)*Math.cos(dtr(long1 - long2)))
      if distance < 4
        @coords << {coord: coord, distance: distance}
      end
    end
    @coords = @coords.sort_by{|c| c[:distance]}
    render partial: 'get_buildings', object: @coords
  end
end