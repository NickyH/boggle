seconds = 10
window.app =
  pusher: null
  channel: null
  selected_channel: null
  document_ready: ->
    app.token = $('#auth_token').data('auth-token')
    $('#form').on('click', 'a[data-clear-form]', app.clear_form)
    $('.word_enter').on('keypress', 'text', app.word_enter)

  word_enter: (e) ->
    e.preventDefault
    if e.keyCode == 13
      word = $('.word_enter').text()
      settings =
      dataType: 'script'
      type: "post"
      url: "/games/add_word"
      data: {authenticity_token: app.token, word: word}
    $.ajax(settings)

  clear_form: (e) ->
    e.preventDefault()
    $('#form').slideUp()
    $('#homebuttons').show()

  bind_events: ->
    channel.bind('select_channel', app.select_channel)


  start_timer: ->
    app.timer = setInterval ( -> app.show_time()), 1000

  show_time: ->
    minutes = Math.floor(seconds/60)
    secs = seconds - (minutes * 60)
    $('#time').text("0#{minutes} : #{secs}")
    seconds -= 1
    if seconds < 0
      clearInterval(app.timer)
      app.end_game()


  end_game: ->
    console.log('end')
    settings =
      dataType: 'script'
      type: 'get'
      url: "/end_game"
    $.ajax(settings)

  new_game_form: ->
    settings =
      dataType: 'script'
      type: "get"
      url: "/games/new_game_form"
    $.ajax(settings)

$(document).ready(app.document_ready)
