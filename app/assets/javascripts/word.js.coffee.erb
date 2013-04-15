window.app =
  seconds: 180
  pusher: null
  channel: null
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

  enter_channel: (name) ->
    name = $('#enterchannel').val()
    console.log(name)
    app.pusher.subscribe(name)
    app.selected_channel = name

  bind_events: ->
    channel.bind('refresh_words', app.refresh_words)
    channel.bind('start_game', app.start_game)

  start_game: (name) ->
    settings =
      dataType: 'script'
      type: "get"
      url: "/games/start_game/#{name}"
    $.ajax(settings)

  refresh_words: (name) ->
    settings =
      dataType: 'script'
      type: "get"
      url: "/games/refresh_words/#{name}"
    $.ajax(settings)

  start_timer: ->
    app.timer = setInterval ( -> app.show_time()), 1000

  show_time: ->
    minutes = Math.floor(app.seconds/60)
    secs = app.seconds - (minutes * 60)
    $('#time').text("0#{minutes} : #{secs}")
    app.seconds -= 1
    if app.seconds < 0
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
