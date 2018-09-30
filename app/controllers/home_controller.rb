class HomeController < ApplicationController
  def map
    @stations = Station.all
  end

  def nearest
    lat = params[:lat]
    lng = params[:lng]
    coords = Geokit::LatLng.new(lat, lng)
    station = Station.by_distance(origin: coords).first
    distance = station.distance_to(coords)
    render json: {
        distance: distance,
        station: station
    }
  end

  def station
    @station = Station.find(params[:id])
  end

  def price
    Station.find(params[:id]).update_attribute(:price, params[:price].to_f)
  end
end
