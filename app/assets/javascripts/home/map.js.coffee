showNearest = (item) ->
  $('#details').text("#{item.station.display_name} (#{item.distance_readable}) - #{item.cena_readable}")
  $('#nearest-link').text(item.station.display_name)
  $('#nearest-link').attr('href', item.station.id)
  $('#nearest').show()

showMultiple = (list, max_dist) ->
  for item in list
    if item.distance <= max_dist
      $('#choose-from').append("<li>#{item.station.display_name} (#{item.distance_readable}) - #{item.cena_readable}</li>")
  $('#choose-from').show()

getZoom = (distance) ->
  console.log(distance)
  rawZoom = parseInt(13 - Math.log(distance) * 2)
  console.log(rawZoom)
  if rawZoom > 18 then 18 else if rawZoom < 8 then 8 else rawZoom

$ ->
  navigator.geolocation.getCurrentPosition (position) ->
    url = "/#{position.coords.latitude}/#{position.coords.longitude}"
    console.log(url)
    $.ajax
      url: url,
      success: (list) ->
        first = list[0]
        map.setView([position.coords.latitude, position.coords.longitude], getZoom(first.distance))
        marker.openPopup()
        if first.distance < 0.2 && second.distance > 2 * first.distance
#         only first
          showNearest(item)
          $('#choose-from').hide()
        else if first.distance < 0.2
#          alternatives are those with distance < 2 * first.distance
          showNearest(item)
          showMultiple(list, 2 * first.distance)
        else
#          choose from those with distance < 2 * first.distance
          console.log("Choose from multiple")
          showMultiple(list, 2 * first.distance)
          $('#nearest').hide()
