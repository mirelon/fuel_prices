DatabaseCleaner.clean_with(:truncation)

post_data = '(
  area[name="Slovensko"];(node[amenity=fuel](area););
);
out;'

require 'net/http'
doc = Net::HTTP.post_form(URI('http://overpass-api.de/api/interpreter'), data: post_data).body
xml = Nokogiri::XML(doc)
xml.css('node').each do |node|
  id = node.attr('id')
  puts "Parsing #{id}"
  lat = node.attr('lat')
  lng = node.attr('lon')
  brand = node.css('tag[k=brand]').first.try(:attr, 'v')
  name = node.css('tag[k=name]').first.try(:attr, 'v')
  operator = node.css('tag[k=operator]').first.try(:attr, 'v')
  opening_hours = node.css('tag[k=opening_hours]').first.try(:attr, 'v')
  toilets = node.css('tag[k=toilets]').first.try{|tag| tag.attr('v') == 'yes'}
  shop = node.css('tag[k=shop]').first.try{|tag| tag.attr('v') == 'yes'}
  Station.create(
             id: id,
             lat: lat,
             lng: lng,
             brand: brand,
             name: name,
             operator: operator,
             opening_hours: opening_hours,
             toilets: toilets,
             shop: shop
  )
end




