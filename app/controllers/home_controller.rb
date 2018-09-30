class HomeController < ApplicationController
  def map
    @stations = Station.all
  end
end
