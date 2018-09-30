$ ->
  navigator.geolocation.getCurrentPosition (position) ->
    url = "http://localhost:3000/#{position.coords.latitude}/#{position.coords.longitude}"
    console.log(url)
    $.ajax
      url: url,
      success: (data) ->
        distance = data.distance
        km = parseInt(distance)
        m = parseInt(1000 * (distance - km))
        details = ' ('
        if km > 0
          details += km + 'km, '
        if m > 0
          details += m + 'm'
        if data.station.price
          details += ', ' + data.station.price + '€, posledná aktualizácia: ' + data.station.posledna_aktualizacia
        else
          details += ', nikto ešte nezaznamenal cenu'
        details += ')'

        $('#details').text(details)
        $('#nearest-link').text(data.station.name)
        $('#nearest-link').attr('href', data.station.id)

