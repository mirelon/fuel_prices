$ ->
  $('#submit').click ->
    station_id = $('#station-id').val()
    price = $('#price-input').val()
    url = "/price/#{station_id}/#{price}"
    console.log(url)
    $.ajax
      url: url,
      type: 'POST',
      success: (data) ->
        location.reload()
