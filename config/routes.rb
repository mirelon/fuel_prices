Rails.application.routes.draw do
  get '/' => 'home#map'
  get ':lat/:lng' => 'home#nearest', constraints: {lat: /\-?\d+(.\d+)?/, lng: /\-?\d+(.\d+)?/}, as: :nearest
  get '/:id' => 'home#station'
  post '/price/:id/:price' => 'home#price', constraints: {price: /\d+(.\d+)?/}
end
