$ ->
  navigator.geolocation.getCurrentPosition (position) ->
    url = "http://localhost:3000/#{position.coords.latitude}/#{position.coords.longitude}"
    console.log(url)
    $.ajax
      url: url,
      success: (list) ->
        first = list[0]
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

showNearest = (item) ->
  $('#details').text("#{item.station.name} (#{item.distance_readable}) - #{item.cena_readable}")
  $('#nearest-link').text(item.station.name)
  $('#nearest-link').attr('href', item.station.id)
  $('#nearest').show()

showMultiple = (list, max_dist) ->
  for item in list
    if item.distance <= max_dist
      $('#choose-from').append("<li>#{item.station.name} (#{item.distance_readable}) - #{item.cena_readable}</li>")
  $('#choose-from').show()
