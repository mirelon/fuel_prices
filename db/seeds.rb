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

post_data = '(
  area[name="Slovensko"];
  way["amenity"="fuel"](area);
);
out body;>;out skel qt;'

require 'net/http'
doc = Net::HTTP.post_form(URI('http://overpass-api.de/api/interpreter'), data: post_data).body
xml = Nokogiri::XML(doc)
xml.css('way').each do |way|
  id = way.attr('id')
  puts "Parsing #{id}"
  brand = way.css('tag[k=brand]').first.try(:attr, 'v')
  name = way.css('tag[k=name]').first.try(:attr, 'v')
  operator = way.css('tag[k=operator]').first.try(:attr, 'v')
  opening_hours = way.css('tag[k=opening_hours]').first.try(:attr, 'v')
  toilets = way.css('tag[k=toilets]').first.try{|tag| tag.attr('v') == 'yes'}
  shop = way.css('tag[k=shop]').first.try{|tag| tag.attr('v') == 'yes'}
  node_count = 0
  sum_lat = 0
  sum_lng = 0
  way.css('nd').each do |nd|
    node = xml.css("node\##{nd.attr('ref')}").first
    if node
      sum_lat += node.attr('lat').to_f
      sum_lng += node.attr('lon').to_f
      node_count += 1
    else
      puts "Wrong nd ref #{nd.attr('ref')}"
    end
  end
  if node_count > 0
    Station.create(
        id: id,
        lat: sum_lat / node_count,
        lng: sum_lng / node_count,
        brand: brand,
        name: name,
        operator: operator,
        opening_hours: opening_hours,
        toilets: toilets,
        shop: shop
    )
  end
end




