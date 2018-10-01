class HomeController < ApplicationController
  def map
    @stations = Station.all
  end

  def nearest
    lat = params[:lat]
    lng = params[:lng]
    coords = Geokit::LatLng.new(lat, lng)
    stations = Station.by_distance(origin: coords).first(5)
    list = stations.map do |station|
      distance = station.distance_to(coords)
      km = distance.to_i
      m = (1000 * (distance - km)).to_i
      distance_readable = [km>0?"#{km}km":nil, m>0?"#{m}m":nil].compact.join(' ')
      {
          distance: station.distance_to(coords),
          distance_readable: distance_readable,
          cena_readable: station.price ? "#{station.price}€ (#{station.posledna_aktualizacia})" : 'nikto ešte nezaznamenal cenu',
          station: station
      }
    end
    render json: list
  end

  def station
    @station = Station.find(params[:id])
  end

  def price
    Station.find(params[:id]).update_attribute(:price, params[:price].to_f)
  end
end
